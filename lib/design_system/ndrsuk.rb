require_relative 'nhsuk'

# This is the NDRS branding adapter for the design system

require_relative 'builders/ndrsuk/fixed_elements'
require_relative 'builders/ndrsuk/table'

DesignSystem::Registry.register('ndrsuk')
