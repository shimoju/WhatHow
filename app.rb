class WhatHow < Sinatra::Base
  configure do
    enable :sessions

    set twitter_api_key: ENV['TWITTER_API_KEY'], twitter_api_secret: ENV['TWITTER_API_SECRET']
    use OmniAuth::Builder do
      provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
    end
  end

  configure :production do
    use Rack::SSL
  end

  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  helpers do
    def create_twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key = settings.twitter_api_key
        config.consumer_secret = settings.twitter_api_secret
        config.access_token = session[:user][:token]
        config.access_token_secret = session[:user][:secret]
      end
    end
  end

  get '/' do
    unless session[:user]
      slim :index
    else
      slim :home
    end
  end

  get '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']
    session[:user] = {
      name: auth.info.name,
      username: auth.info.nickname,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret
    }
    redirect to('/')
  end

  get '/logout' do
    session[:user] = nil
    redirect to('/')
  end
end
