require 'bundler/gem_tasks'
require 'dotenv/tasks'
require File.expand_path('../lib/koin', __FILE__)

task :renew_token => :dotenv do
  access_token = Koin::Persistence.access_token
  expires = Koin::Persistence.expires

  (puts 'Missing token'; exit) unless access_token

  if !expires || expires <= Time.now.to_s
    access_info = facebook_oauth.exchange_access_token_info(access_token)

    Koin::Persistence.access_token = access_info['access_token']
    Koin::Persistence.expires = Time.now + access_info['expires'].to_i

    puts 'Token refresh OK!'
  end
end

task :crawl => :renew_token do
  puts 'Starting crawler...'
  Koin::Workers::Crawler.perform_async
end

def facebook_oauth
  Koala::Facebook::OAuth.new(ENV['FB_APP_ID'], ENV['FB_APP_SECRET'])
end
