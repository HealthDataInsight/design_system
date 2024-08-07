require_relative 'base'
require 'design_system/components/govuk/table'

# This is the design system module
module DesignSystem
  # This is the GOV.UK adapter for the design system
  class Govuk < Base
    include DesignSystem::Components::Govuk::Table

    private

    # def render_main_container(&)
    #   content_tag(:div, class: 'govuk-grid-column-two-thirds', &)
    # end

    def render_main_heading
      content_tag(:h1, @main_heading, class: "#{brand}-heading-xl")
    end

    def content_for_breadcrumbs
      content_for(:breadcrumbs) do
        content_tag(:div, class: "#{brand}-breadcrumbs") do
          content_tag(:ol, class: "#{brand}-breadcrumbs__list") do
            @breadcrumbs.each_with_object(ActiveSupport::SafeBuffer.new) do |breadcrumb, safe_buffer|
              safe_buffer.concat(render_breadcrumb(breadcrumb))
            end
          end
        end
      end
    end

    def render_breadcrumb(breadcrumb)
      content_tag(:li, class: "#{brand}-breadcrumbs__list-item") do
        link_to(breadcrumb[:label],
                breadcrumb[:path],
                class: "#{brand}-breadcrumbs__link",
                'aria-current': @context.current_page?(breadcrumb[:path]) ? 'page' : nil)
      end
    end
  end

  Registry.register(Govuk)
end
