# frozen_string_literal: true

# This is the NDRS branding adapter for the design system

require_relative 'nhsuk'
require_relative 'builders/ndrsuk/fixed_elements'
require_relative 'builders/ndrsuk/tab'
require_relative 'builders/ndrsuk/table'
require_relative 'form_builders/ndrsuk'

DesignSystem::Registry.register('ndrsuk')
