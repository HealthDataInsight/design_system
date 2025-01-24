require_relative 'nhsuk'

# This is the NDRS branding adapter for the design system

require_relative 'builders/ndrsuk/button'
require_relative 'builders/ndrsuk/fixed_elements'
require_relative 'builders/ndrsuk/notification'
require_relative 'builders/ndrsuk/pagination_renderer'
require_relative 'builders/ndrsuk/tab'
require_relative 'builders/ndrsuk/table'

DesignSystem::Registry.register('ndrsuk')
