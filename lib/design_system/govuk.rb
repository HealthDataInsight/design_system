require_relative 'base'
require_relative 'components/govuk/breadcrumbs'
require_relative 'components/govuk/headings'
require_relative 'components/govuk/table'

# This is the design system module
module DesignSystem
  # This is the GOV.UK adapter for the design system
  class Govuk < Base
    include Components::Govuk::Breadcrumbs
    include Components::Govuk::Headings
    include Components::Govuk::Table

    # private

    # def render_main_container(&)
    #   content_tag(:div, class: 'govuk-grid-column-two-thirds', &)
    # end
  end

  Registry.register(Govuk)
end
