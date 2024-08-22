require_relative 'base'
require_relative 'components/govuk/breadcrumbs'

# This is the design system module
module DesignSystem
  # This is the GOV.UK adapter for the design system
  class Govuk < Base
    include Components::Govuk::Breadcrumbs

    private

    # def render_main_container(&)
    #   content_tag(:div, class: 'govuk-grid-column-two-thirds', &)
    # end

    def render_main_heading
      content_tag(:h1, @main_heading, class: "#{brand}-heading-xl")
    end
  end

  Registry.register(Govuk)
end
