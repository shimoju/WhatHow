ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])
Dotenv.load if defined?(Dotenv)

class WhatHow < Sinatra::Base
  configure do
    enable :sessions
    set :protection, except: :remote_token
    use Rack::Protection::AuthenticityToken

    set :assets_precompile, %w(application.js application.css *.png *.jpg *.svg *.eot *.ttf *.woff) + %w(jquery.js)
    set :assets_css_compressor, :sass
    set :assets_js_compressor, :uglifier
    register Sinatra::AssetPipeline
    if defined?(RailsAssets)
      RailsAssets.load_paths.each { |path| settings.sprockets.append_path(path) }
    end

    use OmniAuth::Builder do
      provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
    end
  end

  configure :production do
    set :session_secret, ENV['SESSION_SECRET']
    use Rack::SSL
  end

  configure :development do
    set :session_secret, '863a600a5252977c643137ba719628a51d7005ad2bada16546d37926025ce3404934192ea1975be2fcf75950026e245da528a5620411833bcfe5e13efb450314'
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  helpers do
    def token_tag
      %Q(<input name="authenticity_token" type="hidden" value="#{session[:csrf]}" />)
    end

    def signed_in?
      session[:user] ? true : false
    end

    def create_twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_API_KEY']
        config.consumer_secret = ENV['TWITTER_API_SECRET']
        config.access_token = session[:user][:token]
        config.access_token_secret = session[:user][:secret]
      end
    end
  end

  get '/' do
    if signed_in?
      slim :whathow
    else
      slim :index
    end
  end

  get '/tweet-button' do
    redirect to('/') if signed_in?
    slim :whathow
  end

  post '/tweet' do
    redirect to('/') unless signed_in?
    tweet = "#{params[:what]}#{params[:how]} #WhatHow"
    redirect to('/') if Twitter::Validation.tweet_invalid?(tweet)
    twitter = create_twitter_client
    twitter.update(tweet)
    redirect to('/')
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
