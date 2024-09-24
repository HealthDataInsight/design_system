require_relative 'nhsuk'

# This is the NDRS branding adapter for the design system

require_relative 'builders/ndrsuk/fixed_elements'
require_relative 'builders/ndrsuk/table'
require_relative 'builders/ndrsuk/tab'

DesignSystem::Registry.register('ndrsuk')
