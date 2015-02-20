ruby '2.2.0'
source 'https://rubygems.org'

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

source 'https://rails-assets.org' do
  gem 'rails-assets-normalize.css'
  gem 'rails-assets-jquery'
end

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
