module Koin
  module Workers
    class Uploader
      include Sidekiq::Worker
      sidekiq_options queue: :uploader, retry: 5

      def initialize
        @client = DropboxClient.new(ENV['DP_ACCESS_TOKEN'])
      end

      def perform(id, path)
        filename = path.gsub('tmp/songs/', '')
        file = File.open(path.chomp)
        @client.put_file(filename, file)

        logger.info "Uploaded #{filename} succesfully!"

        share_link = @client.shares(filename)
        Koin::Workers::Commenter.perform_async(id, share_link['url'])
      end
    end
  end
end
