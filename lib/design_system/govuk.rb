# frozen_string_literal: true

# This is the GOV.UK adapter for the design system

require_relative 'govuk/builders/back_link'
require_relative 'govuk/builders/button'
require_relative 'govuk/builders/callout'
require_relative 'govuk/builders/details'
require_relative 'govuk/builders/fixed_elements'
require_relative 'govuk/builders/heading'
require_relative 'govuk/builders/link'
require_relative 'govuk/builders/notification'
require_relative 'govuk/builders/pagination_renderer'
require_relative 'govuk/builders/panel'
require_relative 'govuk/builders/summary_list'
require_relative 'govuk/builders/tab'
require_relative 'govuk/builders/table'

require_relative 'govuk/form_builder'

DesignSystem::Registry.register('govuk')
