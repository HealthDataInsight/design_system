require_relative 'nhsuk'

# This is the NDRS branding adapter for the design system

require_relative 'ndrsuk/builders/button'
require_relative 'ndrsuk/builders/callout'
require_relative 'ndrsuk/builders/fixed_elements'
require_relative 'ndrsuk/builders/heading'
require_relative 'ndrsuk/builders/link'
require_relative 'ndrsuk/builders/notification'
require_relative 'ndrsuk/builders/pagination_renderer'
require_relative 'ndrsuk/builders/panel'
require_relative 'ndrsuk/builders/summary_list'
require_relative 'ndrsuk/builders/tab'
require_relative 'ndrsuk/builders/table'

require_relative 'ndrsuk/form_builder'

DesignSystem::Registry.register('ndrsuk')
