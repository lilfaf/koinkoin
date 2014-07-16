require 'uri'

module Koin
  module Workers
    class Crawler
      include Sidekiq::Worker
      sidekiq_options queue: :crawler, retry: false

      YOUTUBE_URL_REGEX=/(youtu(?:\.be|be\.com)\/(?:.*v(?:\/|=)|(?:.*\/)?)([\w'-]+))/i
      SOUNDCLOUD_URL_REGEX=/^https?:\/\/(soundcloud.com|snd.sc)\/(.*)$/

      def perform
        feed  = api.get_connections(ENV['FB_GROUP_ID'], 'feed')
        while feed
          feed.each do |post|
            @url = post['link'] || URI.extract(post['message'] || '').first
            next unless @url

            if valid_url?
              logger.info "VALID: #{@url}"
            else
              logger.info "Invalid url #{@url}"
            end
          end
          feed = feed.next_page
        end
      end

      private

      def api
        Koala::Facebook::API.new(Koin::Persistence.access_token)
      end

      def valid_url?
        sanitize_url
        @url && (@url.match(YOUTUBE_URL_REGEX) || @url.match(SOUNDCLOUD_URL_REGEX))
      end

      def sanitize_url
        @url = @url.sub(/\?list=[^&]*/, '?').sub(/\&list=[^&]*/, '').sub(/\?$/,'')
      end
    end
  end
end
