source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in design_system.gemspec.
gemspec

# Shared development and test dependencies (single source of truth, also used by
# the per-Rails-version gemfiles under gemfiles/).
eval_gemfile 'gemfiles/common.rb'

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

# This Gemfile is the default local/development bundle and tracks the latest
# supported Rails line. The gemfiles/ directory holds the other Rails versions
# exercised by CI. Rails 8.0+ requires sqlite3 >= 2.1.
gem 'sqlite3', '~> 2.1'
