set :output, File.expand_path('../../log/cron.log', __FILE__)

every 1.minute do
  rake 'crawl'
end
