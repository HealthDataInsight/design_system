source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in design_system.gemspec.
gemspec

gem 'puma', '>= 6.4.3'

gem 'sprockets-rails'

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
gem 'dartsass-rails', '~> 0.5'
gem 'importmap-rails', '~> 2.1'
gem 'ndr_dev_support', '~> 7.3'
gem 'sqlite3', '~> 1.3'

group :development, :test do
  gem 'cypress-rails'
end

group :test do
  gem 'mocha', '~> 2.2.0'
end

# charlock_holmes: Version 0.7.7 has known issues with dependency resolution on Apple Silicon (M3) Macs.
# Upgrading to 0.7.9 or higher resolves these compatibility issues.
gem 'charlock_holmes', '>= 0.7.9'
