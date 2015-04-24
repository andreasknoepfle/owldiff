if ENV['CI']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start do
    add_filter "test/*"
  end
end

require 'owldiff'

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'
