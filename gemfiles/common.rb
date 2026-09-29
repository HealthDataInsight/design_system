# frozen_string_literal: true

# Shared development and test dependencies for the dummy app and test suite.
#
# This file is evaluated by the root Gemfile and by each of the per-Rails-version
# gemfiles in this directory (via `eval_gemfile`), so it is the single source of
# truth for these gems. It deliberately does NOT declare `rails` or `sqlite3`:
# those are pinned per Rails version (Rails 8.0+ requires sqlite3 >= 2.1, whereas
# 7.1/7.2 require >= 1.4), and Bundler forbids declaring the same gem twice.

gem 'puma', '>= 6.4.3'

gem 'sprockets-rails'

# json 3.x removed the `quirks_mode` keyword that Rails' cookie middleware still
# passes (through at least Rails 8.0.5.1), so cap below 3 until Rails stops using it.
gem 'json', '< 3'

# minitest 6.x is incompatible with the Rails 7.1/7.2 test runner
# (railties' line_filtering passes an extra argument to Minitest::Runnable#run).
gem 'minitest', '< 6'

gem 'dartsass-rails', '~> 0.5.1'
gem 'importmap-rails', '~> 2.1'
gem 'ndr_dev_support', '~> 7.3'

group :development, :test do
  gem 'cypress-rails'
end

group :test do
  gem 'mocha', '~> 2.2.0'
end

# charlock_holmes: Version 0.7.7 has known issues with dependency resolution on Apple Silicon (M3) Macs.
# Upgrading to 0.7.9 or higher resolves these compatibility issues.
gem 'charlock_holmes', '>= 0.7.9'
