# frozen_string_literal: true

# This is the HDI branded adapter for the design system

require_relative 'builders/hdi/button'
require_relative 'builders/hdi/fixed_elements'
require_relative 'builders/hdi/pagination_renderer'
require_relative 'builders/hdi/tab'
require_relative 'builders/hdi/table'

DesignSystem::Registry.register('hdi')
