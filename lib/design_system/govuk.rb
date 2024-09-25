# frozen_string_literal: true

# This is the GOV.UK adapter for the design system

require_relative 'builders/govuk/fixed_elements'
require_relative 'builders/govuk/tab'
require_relative 'builders/govuk/table'

DesignSystem::Registry.register('govuk')
