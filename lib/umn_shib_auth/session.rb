# frozen_string_literal: true

module UmnShibAuth
  class Session
    attr_reader :internet_id, :institution_tld

    def initialize(options = {}, request_env = {})
      options.symbolize_keys!
      options.merge(request_env).each do |name, value|
        instance_variable_set("@#{name}", value)
        self.class.send(:attr_accessor, name)
      end
      @internet_id, @institution_tld = @eppn.to_s.split('@')
    end
  end
end
