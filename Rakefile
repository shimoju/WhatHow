require 'sinatra/asset_pipeline/task'
require_relative 'app'

Sinatra::AssetPipeline::Task.define! WhatHow

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end
