source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in design_system.gemspec.
gemspec

gem 'puma'

gem 'sprockets-rails'

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
gem 'dartsass-rails', '~> 0.5'
gem 'importmap-rails', '~> 2.1'
gem 'ndr_dev_support', '~> 7.2'
gem 'sqlite3', '~> 1.3'

group :development, :test do
  gem 'cypress-rails'
end

group :test do
  gem 'mocha', '~> 2.2.0'
end
