# frozen_string_literal: true

# This is the HDI branded adapter for the design system

require_relative 'builders/hdi/fixed_elements'
require_relative 'builders/hdi/table'
require_relative 'builders/hdi/tab'

DesignSystem::Registry.register('hdi')
