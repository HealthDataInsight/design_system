require_relative 'govuk'
require_relative 'builders/nhsuk/breadcrumbs'
require_relative 'builders/nhsuk/table'

# Extend the design system module to include Nhsuk
module DesignSystem
  # This is the NHSUK adapter for the design system
  class Nhsuk < Govuk
    include Builders::Nhsuk::Breadcrumbs

    # private

    # def render_main_container(&)
    #   content_tag(:div, class: "#{brand}-width-container", &)
    # end
  end

  Registry.register(Nhsuk)
end
