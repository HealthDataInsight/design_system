# frozen_string_literal: true

require_relative 'nhsuk/builders/code'
require_relative 'nhsuk/builders/fixed_elements'
require_relative 'nhsuk/builders/pagination_renderer'

require_relative 'nhsuk/form_builder'

# This is the NHSUK adapter for the design system
DesignSystem::Registry.register('nhsuk')
