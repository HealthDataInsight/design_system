require_relative 'govuk'
require_relative 'components/nhsuk/breadcrumbs'

# Extend the design system module to include Nhsuk
module DesignSystem
  # This is the NHSUK adapter for the design system
  class Nhsuk < Govuk
    include Components::Nhsuk::Breadcrumbs

    private

    # def render_main_container(&)
    #   content_tag(:div, class: "#{brand}-width-container", &)
    # end
  end

  Registry.register(Nhsuk)
end
