# frozen_string_literal: true

module UmnShibAuth
  require 'umn_shib_auth/session'
  require 'umn_shib_auth/controller_methods'

  class StubbingNotEnabled < StandardError
  end

  mattr_accessor :eppn_variable, :emplid_variable, :display_name_variable

  def self.set_global_defaults!
    self.eppn_variable = 'eppn'
    self.emplid_variable = 'umnEmplId'
    self.display_name_variable = 'displayName'
  end

  def self.using_stub_internet_id?
    ENV.key?('STUB_INTERNET_ID')
  end

  def self.stubbing_enabled?
    %w[development test].include?(Rails.env)
  end

  def self.using_stubs?
    using_stub_internet_id? || stubbed_attributes?
  end

  def self.stub_internet_id
    raise StubbingNotEnabled unless stubbing_enabled?

    ENV['STUB_INTERNET_ID'] || ENV['STUB_X500']
  end

  def self.stubbed_attributes?
    !stubbed_attributes.blank?
  end

  def self.stubbed_attributes
    stubbed_attributes = {}
    if stubbing_enabled?
      begin
        stubbed_attributes = YAML.load_file("#{Rails.root}/config/stubbed_attributes.yml")
      rescue Errno::ENOENT
        Rails.logger.error 'could not load config/stubbed_attributes.yml file'
      end
      Rails.logger.info "attributes: #{stubbed_attributes}"
    end
    stubbed_attributes
  end

  def self.stub_emplid
    raise StubbingNotEnabled unless stubbing_enabled?

    ENV['STUB_EMPLID']
  end

  def self.stub_display_name
    raise StubbingNotEnabled unless stubbing_enabled?

    ENV['STUB_DISPLAY_NAME']
  end

  set_global_defaults!
end
