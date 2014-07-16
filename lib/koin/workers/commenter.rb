# encoding: utf-8
module Koin
  module Workers
    class Commenter
      include Sidekiq::Worker
      sidekiq_options queue: :commenter

      def initialize
        @api = Koala::Facebook::API.new(Koin::Persistence.access_token)
      end

      def perform(id, url)
        @api.put_comment(id, "J'ai traité ce post! Le fichier mp3 est disponible ici... #{url}")
        logger.info "Commented post #{id} succesfully!"
      end
    end
  end
end
