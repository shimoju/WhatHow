ENV['RACK_ENV'] = 'test'

require 'spec_helper'
require_relative '../app'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    @app ||= WhatHow
  end
end
