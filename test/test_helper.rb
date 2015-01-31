ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

require "mocha/mini_test"
require "webmock/minitest"
WebMock.disable_net_connect!(:allow_localhost => true)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include OmniAuthTestHelpers
end

# Add warden helpers to controller tests.
class ActionController::TestCase
  include WardenControllerTestHelpers
end

OmniAuth.config.test_mode = true
