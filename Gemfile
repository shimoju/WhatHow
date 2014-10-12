ruby '2.1.3'
source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib', require: false
gem 'sinatra-asset-pipeline', require: 'sinatra/asset_pipeline'
gem 'uglifier'

gem 'foreman', require: false
gem 'puma', require: false

gem 'slim'
gem 'compass'
gem 'omniauth-twitter'
gem 'twitter'
gem 'twitter-text'

gem 'rails-assets-normalize.css'
gem 'rails-assets-jquery'

group :production do
  gem 'rack-ssl'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'rack-test'
end

group :development, :test do
  gem 'rspec'
  gem 'dotenv'
end
