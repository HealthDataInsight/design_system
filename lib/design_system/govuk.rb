# frozen_string_literal: true

# This is the GOV.UK adapter for the design system

require_relative 'govuk/builders/code'
require_relative 'govuk/builders/fixed_elements'
require_relative 'govuk/builders/pagination_renderer'

require_relative 'govuk/form_builder'

DesignSystem::Registry.register('govuk')
