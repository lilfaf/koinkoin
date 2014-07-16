require 'koin/version'

require 'koala'
require 'sidekiq'
require 'dotenv'
Dotenv.load

require 'koin/persistence'
require 'koin/web'
require 'koin/workers/crawler'

module Koin
end
