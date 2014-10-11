require 'sinatra_helper'

RSpec.describe WhatHow do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(last_response).to be_ok
    end
  end
end
