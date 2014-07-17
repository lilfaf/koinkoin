require 'koin/version'

require 'uri'
require 'open3'
require 'dropbox_sdk'
require 'koala'
require 'redis'
require 'sidekiq'
require 'dotenv'
require 'dotenv/deployment'

require 'koin/persistence'
require 'koin/web'
require 'koin/workers/crawler'
require 'koin/workers/extractor'
require 'koin/workers/uploader'
require 'koin/workers/commenter'

module Koin
  Sidekiq.configure_client do |config|
    config.redis = ConnectionPool.new(size: 5, timeout: 1) do
      Redis.new(host: ENV['REDIS_HOST'])
    end
  end
end
