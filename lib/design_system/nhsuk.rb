# frozen_string_literal: true

require_relative 'builders/nhsuk/fixed_elements'
require_relative 'builders/nhsuk/table'

# Extend the design system module to include Nhsuk
module DesignSystem
  # This is the NHSUK adapter for the design system
  class Nhsuk
  end

  Registry.register(Nhsuk)
end
