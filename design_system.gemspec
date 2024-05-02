require_relative 'lib/design_system/version'

Gem::Specification.new do |spec|
  spec.name        = 'design_system'
  spec.version     = DesignSystem::VERSION
  spec.authors     = ['Tim Gentry']
  spec.email       = ['52189+timgentry@users.noreply.github.com']
  spec.homepage    = 'https://github.com/HealthDataInsight/design_system'
  spec.summary     = 'Design System Engine for GOV.UK, NHS, NDRS and HDI'
  spec.description = 'Ruby on Rails Engine to consistent, compliant sites using ' \
                     'GOV.UK, NHS, NDRS and HDI design systems'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/HealthDataInsight/design_system'
  spec.metadata['changelog_uri'] = 'https://github.com/HealthDataInsight/design_system/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 7.1.3.2'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
