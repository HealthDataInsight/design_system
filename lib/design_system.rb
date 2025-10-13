require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem

# Avoid loading test helpers by default
loader.ignore("#{__dir__}/design_system/*/test_helpers")

loader.setup

require 'design_system/version'
require 'design_system/engine'

# This is the main module for the Design System gem
module DesignSystem
  # Your code goes here...
end
