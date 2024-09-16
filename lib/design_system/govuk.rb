# frozen_string_literal: true

require_relative 'builders/govuk/fixed_elements'
require_relative 'builders/govuk/table'

# This is the design system module
module DesignSystem
  # This is the GOV.UK adapter for the design system
  class Govuk
  end

  Registry.register(Govuk)
end
