module DesignSystem
  module Nhsuk
    # NHS breadcrumbs: an ordered list of breadcrumb links followed by a
    # back link to the last crumb, wrapped in a labelled nav.
    class BreadcrumbsComponent < DesignSystem::Govuk::BreadcrumbsComponent
      def call
        content_tag(:nav, 'aria-label': 'Breadcrumb', class: "#{brand}-breadcrumb") do
          content_tag(:ol, class: "#{brand}-breadcrumb__list") do
            safe_join(breadcrumbs.map { |breadcrumb| render_breadcrumb(breadcrumb) })
          end + back_link
        end
      end

      private

      def render_breadcrumb(breadcrumb)
        content_tag(:li, class: "#{brand}-breadcrumb__list-item") do
          link_to(breadcrumb[:label],
                  breadcrumb[:path],
                  class: "#{brand}-breadcrumb__link",
                  'aria-current': helpers.current_page?(breadcrumb[:path]) ? 'page' : nil)
        end
      end

      def back_link
        link_to(breadcrumbs.last[:path],
                class: "#{brand}-back-link",
                'aria-current': helpers.current_page?(breadcrumbs.last[:path]) ? 'page' : nil) do
          content_tag(:span, 'Back to &nbsp;'.html_safe, class: "#{brand}-u-visually-hidden") +
            breadcrumbs.last[:label]
        end
      end
    end
  end
end
