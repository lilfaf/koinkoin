redis: redis-server
web: rackup -s puma
sidekiq: bundle exec sidekiq -r ./lib/koin.rb -q default -q crawler
