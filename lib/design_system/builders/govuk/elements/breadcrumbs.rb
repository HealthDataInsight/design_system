module DesignSystem
  module Builders
    module Govuk
      module Elements
        # This mixin module is used to provide GOVUK breadcrumbs.
        module Breadcrumbs
          private

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
      end
    end
  end
end
