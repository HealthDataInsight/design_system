# frozen_string_literal: true

# This is the NHSUK adapter for the design system

require_relative 'builders/nhsuk/fixed_elements'
require_relative 'builders/nhsuk/tab'
require_relative 'builders/nhsuk/table'
require_relative 'form_builders/nhsuk'

DesignSystem::Registry.register('nhsuk')
