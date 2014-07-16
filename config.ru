require 'rubygems'
require 'bundler'

Bundler.setup

require 'koin'
require 'sidekiq/web'

run Rack::URLMap.new('/' => Koin::Web, '/sidekiq' => Sidekiq::Web)
