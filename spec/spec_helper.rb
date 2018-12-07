# frozen_string_literal: true

require 'active_support/dependencies/autoload'
require 'action_controller'
require 'umn_shib_auth'
require 'logger'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.order = :random
  Kernel.srand config.seed
end

class Rails
  class << self
    attr_accessor :logger, :env, :root
  end
end

Rails.logger = Logger.new('/dev/null')
Rails.env = 'test'
Rails.root = "#{__dir__}/fixtures"

class DummyController < ActionController::Base
  include UmnShibAuth::ControllerMethods
end
