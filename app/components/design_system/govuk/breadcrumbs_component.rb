module DesignSystem
  module Govuk
    # GOV.UK breadcrumbs: an ordered list of breadcrumb links.
    class BreadcrumbsComponent < DesignSystem::Generic::BreadcrumbsComponent
      def call
        content_tag(:div, class: "#{brand}-breadcrumbs") do
          content_tag(:ol, class: "#{brand}-breadcrumbs__list") do
            safe_join(breadcrumbs.map { |breadcrumb| render_breadcrumb(breadcrumb) })
          end
        end
      end

      private

      def render_breadcrumb(breadcrumb)
        content_tag(:li, class: "#{brand}-breadcrumbs__list-item") do
          link_to(breadcrumb[:label],
                  breadcrumb[:path],
                  class: "#{brand}-breadcrumbs__link",
                  'aria-current': helpers.current_page?(breadcrumb[:path]) ? 'page' : nil)
        end
      end
    end
  end
end
