# frozen_string_literal: true

# This is the HDI branded adapter for the design system

require_relative 'hdi/builders/button'
require_relative 'hdi/builders/callout'
require_relative 'hdi/builders/fixed_elements'
require_relative 'hdi/builders/heading'
require_relative 'hdi/builders/link'
require_relative 'hdi/builders/notification'
require_relative 'hdi/builders/pagination_renderer'
require_relative 'hdi/builders/panel'
require_relative 'hdi/builders/summary_list'
require_relative 'hdi/builders/tab'
require_relative 'hdi/builders/table'

require_relative 'hdi/form_builder'

DesignSystem::Registry.register('hdi')
