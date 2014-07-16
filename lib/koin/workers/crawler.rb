require 'uri'

module Koin
  module Workers
    class Crawler
      include Sidekiq::Worker
      sidekiq_options queue: :crawler, retry: false

      YOUTUBE_URL_REGEX=/(youtu(?:\.be|be\.com)\/(?:.*v(?:\/|=)|(?:.*\/)?)([\w'-]+))/i
      SOUNDCLOUD_URL_REGEX=/^https?:\/\/(soundcloud.com|snd.sc)\/(.*)$/

      def initialize
        @count = 0
        @api = Koala::Facebook::API.new(Koin::Persistence.access_token)
      end

      def perform
        feed  = @api.get_connections(ENV['FB_GROUP_ID'], 'feed')
        while feed
          feed.each do |post|
            @url = post['link'] || URI.extract(post['message'] || '').first

            if !@url || Koin::Persistence.seen?(@url)
              logger.debug 'Link not found or already seen'
            elsif valid_url?
              Koin::Persistence.mark(@url)
              @count += 1

              @url = sanitized_url
              logger.info "Pushing #{@url} to extraction queue"
            end
          end
          feed = feed.next_page
        end

        logger.info "Found #{@count} tracks"
      end

      def valid_url?
        youtube_url? || soundcloud_url?
      end

      def youtube_url?
        @url.match(YOUTUBE_URL_REGEX)
      end

      def soundcloud_url?
        @url.match(SOUNDCLOUD_URL_REGEX)
      end

      def sanitized_url
        @url.sub(/\?list=[^&]*/, '?').sub(/\&list=[^&]*/, '').sub(/\?$/,'')
      end
    end
  end
end
