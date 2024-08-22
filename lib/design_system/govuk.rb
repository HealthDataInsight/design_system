require_relative 'base'
require_relative 'builders/govuk/breadcrumbs'
require_relative 'builders/govuk/headings'

# This is the design system module
module DesignSystem
  # This is the GOV.UK adapter for the design system
  class Govuk < Base
    include Builders::Govuk::Breadcrumbs
    include Builders::Govuk::Headings

    # private

    # def render_main_container(&)
    #   content_tag(:div, class: 'govuk-grid-column-two-thirds', &)
    # end
  end

  Registry.register(Govuk)
end
