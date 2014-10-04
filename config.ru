require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'] || :development)

require './app'
run WhatHow
