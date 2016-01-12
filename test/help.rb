gem 'minitest'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/test/'
  end
end

require 'rubygems'
require 'minitest/autorun'
require 'minitest/benchmark' if ENV['BENCH']
require 'minitest/pride'

require './lib/ds.rb'
include DS
