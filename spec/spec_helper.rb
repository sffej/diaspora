#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.

ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)
require 'helper_methods'
require 'rspec/rails'
require 'database_cleaner'
require 'webmock/rspec'

include Devise::TestHelpers
include WebMock::API
#
# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
include HelperMethods

RSpec.configure do |config|
  config.mock_with :mocha
  config.mock_with :rspec

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.orm = "mongo_mapper"

  config.before(:each) do
    I18n.locale = :en
    RestClient.stub!(:post).and_return(FakeHttpRequest.new(:success))

    DatabaseCleaner.clean
    UserFixer.load_user_fixtures
    $process_queue = false
  end
end

module Diaspora::WebSocket
  def self.redis
    FakeRedis.new
  end
end
class FakeRedis
  def rpop(*args)
    true
  end
  def llen(*args)
    true
  end
  def lpush(*args)
    true
  end
end

ImageUploader.enable_processing = false

class FakeHttpRequest
  def initialize(callback_wanted)
    @callback = callback_wanted
    @callbacks = []
  end

  def callbacks=(rs)
    @callbacks += rs.reverse
  end

  def response
    @callbacks.pop unless @callbacks.nil? || @callbacks.empty?
  end

  def response_header
    self
  end

  def method_missing(method)
    self
  end

  def post(opts = nil);
    self
  end

  def get(opts = nil)
    self
  end

  def publish(opts = nil)
    self
  end

  def callback(&b)
    b.call if @callback == :success
  end

  def errback(&b)
    b.call if @callback == :failure
  end
end
