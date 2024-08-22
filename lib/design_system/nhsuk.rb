require_relative 'govuk'
require_relative 'components/nhsuk/breadcrumbs'
require_relative 'components/nhsuk/table'

# Extend the design system module to include Nhsuk
module DesignSystem
  # This is the NHSUK adapter for the design system
  class Nhsuk < Govuk
    include Components::Nhsuk::Breadcrumbs
    include Components::Nhsuk::Table

    # private

    # def render_main_container(&)
    #   content_tag(:div, class: "#{brand}-width-container", &)
    # end
  end

  Registry.register(Nhsuk)
end
