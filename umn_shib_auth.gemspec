# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'umn_shib_auth/version'

Gem::Specification.new do |s|
  s.name        = 'umn_shib_auth'
  s.version     = UmnShibAuth::VERSION
  s.authors     = ['ASR']
  s.email       = ['asrweb@umn.edu']
  s.homepage    = ''
  s.summary     = 'UmnShibAuth is an authentication plugin for Rails designed ' \
                  'to replace the existing UmnAuth x500 plugin for use with Shibboleth.'
  s.description = 'UmnShibAuth is an authentication plugin for Rails designed ' \
                  'to replace the existing UmnAuth x500 plugin for use with Shibboleth.' \
                  "This plugin should work for all versions of rails--it's been used in Rails 2 through 5."
  s.required_ruby_version = '>= 2.6.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency 'actionpack', '~> 6.0.3'
  s.add_development_dependency 'activesupport', '~> 6.0.3'
  s.add_development_dependency 'bundler', '2.1.4'
  s.add_development_dependency 'overcommit', '~> 0.57'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'rubocop', '~> 0.93'
end
