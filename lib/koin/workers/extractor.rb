module Koin
  module Workers
    class Extractor
      include Sidekiq::Worker
      sidekiq_options queue: :extractor, retry: 3

      DEFAULT_OPTION = {
        format: "mp3",
        quality: "7",
        output: "'tmp/songs/%(title)s.%(ext)s'"
      }

      def perform(id, url, options = {})
        @url = url
        @options = DEFAULT_OPTION.merge!(options)

        # Run external command
        stdout, stderr, exit_status = Open3.capture3(youtube_dl_cmd)
        raise stderr unless exit_status.success?

        # Search for file destination path in youtube-dl outputs
        destination = stdout.scan(/^\[ffmpeg|download\] Destination: (.*)$/).flatten.first.sub(/[^.]+\z/, 'mp3')
        raise "Destination path not found for #{url}" unless destination

        Koin::Workers::Uploader.perform_async(id, destination)

        logger.info "Extracted file to #{destination}"
      end

      def youtube_dl_cmd
        "youtube-dl -x -o #{@options[:output]} "\
        "--audio-format #{@options[:format]} --prefer-ffmpeg "\
        "--audio-quality #{@options[:quality]} \"#{@url}\""
      end
    end
  end
end
