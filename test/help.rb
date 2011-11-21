require 'rubygems'
gem 'minitest'
require 'minitest/autorun'
require "minitest/benchmark" if ENV['BENCH']
require "minitest/pride"

if ENV['COVERAGE']
  SimpleCov.start do
    add_filter "/test/"
  end
end

require './lib/ds.rb'
include DS
