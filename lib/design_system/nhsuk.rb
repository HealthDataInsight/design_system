# frozen_string_literal: true

require_relative 'nhsuk/builders/button'
require_relative 'nhsuk/builders/callout'
require_relative 'nhsuk/builders/fixed_elements'
require_relative 'nhsuk/builders/details'
require_relative 'nhsuk/builders/heading'
require_relative 'nhsuk/builders/link'
require_relative 'nhsuk/builders/notification'
require_relative 'nhsuk/builders/pagination_renderer'
require_relative 'nhsuk/builders/panel'
require_relative 'nhsuk/builders/paragraph'
require_relative 'nhsuk/builders/summary_list'
require_relative 'nhsuk/builders/tab'
require_relative 'nhsuk/builders/table'

require_relative 'nhsuk/form_builder'

# This is the NHSUK adapter for the design system
DesignSystem::Registry.register('nhsuk')
