require_relative 'govuk'

module DesignSystem
  # This is the NHSUK adapter for the design system
  class Nhsuk < Govuk
    private

    def render_main_container(&)
      content_tag(:div, class: "#{brand}-width-container", &)
    end
  end

  Registry.register(Nhsuk, 'nhsuk')
end
