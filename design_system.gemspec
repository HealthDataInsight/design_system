require_relative 'lib/design_system/version'

Gem::Specification.new do |spec|
  spec.name        = 'design_system'
  spec.version     = DesignSystem::VERSION
  spec.authors     = ['Filis Liu', 'Nick Robinson', 'Shilpi Goel', 'Tim Gentry']
  spec.email       = ['52189+timgentry@users.noreply.github.com']
  spec.homepage    = 'https://github.com/HealthDataInsight/design_system'
  spec.summary     = 'Design System Engine for GOV.UK, NHS and other design systems'
  spec.description = 'Ruby on Rails Engine to deliver consistent, compliant sites using ' \
                     'GOV.UK, NHS and other design systems'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.1.6'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/HealthDataInsight/design_system'
  spec.metadata['changelog_uri'] = 'https://github.com/HealthDataInsight/design_system/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib,public}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'govuk_design_system_formbuilder', '~> 5.11.0'
  spec.add_dependency 'rails', '>= 7.0.8.5'
  spec.add_dependency 'stimulus-rails', '~> 1.3'
  spec.add_dependency 'will_paginate', '~> 4.0.1'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
