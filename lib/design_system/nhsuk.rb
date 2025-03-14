# frozen_string_literal: true

require_relative 'builders/nhsuk/button'
require_relative 'builders/nhsuk/fixed_elements'
require_relative 'builders/nhsuk/heading'
require_relative 'builders/nhsuk/notification'
require_relative 'builders/nhsuk/pagination_renderer'
require_relative 'builders/nhsuk/summary_list'
require_relative 'builders/nhsuk/tab'
require_relative 'builders/nhsuk/table'

# This is the NHSUK adapter for the design system
DesignSystem::Registry.register('nhsuk')
