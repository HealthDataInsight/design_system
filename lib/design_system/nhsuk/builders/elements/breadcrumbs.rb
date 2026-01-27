module DesignSystem
  module Nhsuk
    module Builders
      module Elements
        # This mixin module is used to provide NHS breadcrumbs.
        module Breadcrumbs
          private

          def content_for_breadcrumbs
            content_for(:breadcrumbs) do
              content_tag(:nav, 'aria-label': 'Breadcrumb', class: "#{brand}-breadcrumb") do
                content_tag(:div, class: "#{brand}-width-container") do
                  content_tag(:ol, class: "#{brand}-breadcrumb__list") do
                    @breadcrumbs.each_with_object(ActiveSupport::SafeBuffer.new) do |breadcrumb, safe_buffer|
                      safe_buffer.concat(render_breadcrumb(breadcrumb))
                    end
                  end +
                  content_for_back_link
                end
              end
            end
          end

          def content_for_back_link
            link_to(@breadcrumbs.last[:path],
                    class: "#{brand}-back-link",
                    'aria-current': @context.current_page?(@breadcrumbs.last[:path]) ? 'page' : nil) do
              content_tag(:span, 'Back to &nbsp;'.html_safe, class: "#{brand}-u-visually-hidden") +
                @breadcrumbs.last[:label]
            end
          end

          def render_breadcrumb(breadcrumb)
            content_tag(:li, class: "#{brand}-breadcrumb__list-item") do
              link_to(breadcrumb[:label],
                      breadcrumb[:path],
                      class: "#{brand}-breadcrumb__link",
                      'aria-current': @context.current_page?(breadcrumb[:path]) ? 'page' : nil)
            end
          end
        end
      end
    end
  end
end
