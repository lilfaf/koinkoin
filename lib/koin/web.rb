require 'sinatra'
require 'omniauth-facebook'

module Koin
  class Web < Sinatra::Base
    enable :sessions
    set :views, File.expand_path('../../../web/views', __FILE__)
    set :server, :puma

    use OmniAuth::Builder do
      provider :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET'], scope: ENV['FB_SCOPE']
    end

    get '/' do
      erb :index
    end

    get '/auth/facebook/callback' do
      token = request.env['omniauth.auth']['credentials']['token']
      Koin::Persistence.access_token = token
      redirect '/'
    end

    get '/clear' do
      Koin::Persistence.clear
      `rm tmp/songs/*.mp3 tmp/songs/*.m4a tmp/songs/*.part`
      redirect '/'
    end
  end
end
