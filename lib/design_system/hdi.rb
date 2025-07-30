# frozen_string_literal: true

# This is the HDI branded adapter for the design system

require_relative 'builders/hdi/button'
require_relative 'builders/hdi/callout'
require_relative 'builders/hdi/fixed_elements'
require_relative 'builders/hdi/heading'
require_relative 'builders/hdi/link'
require_relative 'builders/hdi/notification'
require_relative 'builders/hdi/pagination_renderer'
require_relative 'builders/hdi/panel'
require_relative 'builders/hdi/summary_list'
require_relative 'builders/hdi/tab'
require_relative 'builders/hdi/table'

require_relative 'form_builders/hdi'

DesignSystem::Registry.register('hdi')
