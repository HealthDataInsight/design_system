# frozen_string_literal: true

require_relative 'builders/hdi/fixed_elements'
require_relative 'builders/hdi/table'

# Extend the design system module to include Hdi
module DesignSystem
  # This is the HDI branded adapter for the design system
  class Hdi
  end

  Registry.register(Hdi)
end
