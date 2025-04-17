module DesignSystem
  module Builders
    module Hdi
      module Elements
        # This concern is used to provide HDI breadcrumbs.
        module Breadcrumbs
          extend ActiveSupport::Concern

          # In this instance the string is safe, because it contains known text.
          # rubocop:disable Rails/OutputSafety
          BREADCRUMB_HOME_SVG = <<~SVG.html_safe
            <svg class="h-5 w-5 shrink-0" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M9.293 2.293a1 1 0 011.414 0l7 7A1 1 0 0117 11h-1v6a1 1 0 01-1 1h-2a1 1 0 01-1-1v-3a1 1 0 00-1-1H9a1 1 0 00-1 1v3a1 1 0 01-1 1H5a1 1 0 01-1-1v-6H3a1 1 0 01-.707-1.707l7-7z" clip-rule="evenodd" />
            </svg>
          SVG
          BREADCRUMB_DIVIDER_SVG = <<~SVG.html_safe
            <svg class="h-5 w-5 shrink-0 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
            </svg>
          SVG
          # rubocop:enable Rails/OutputSafety

          private

          def content_for_breadcrumbs
            content_for(:breadcrumbs) do
              content_tag(:nav, 'aria-label': 'Breadcrumb', class: "#{brand}-breadcrumbs") do
                content_tag(:ol, data: { test: 'breadcrumb_list' }, class: "#{brand}-breadcrumbs__list",
                                 role: 'list') do
                  @breadcrumbs.each_with_object(ActiveSupport::SafeBuffer.new) do |breadcrumb, safe_buffer|
                    safe_buffer.concat(render_breadcrumb(breadcrumb))
                  end
                end
              end
            end
          end

          def render_breadcrumb(breadcrumb)
            is_home_path = home_path?(breadcrumb[:path])
            is_current_page = @context.current_page?(breadcrumb[:path])

            content_tag :li, class: "#{brand}-breadcrumbs__item",
                             data: { test: 'breadcrumb_item' } do
              if is_home_path
                root_path_breadcrumb(breadcrumb)
              else
                content_tag :div, class: "#{brand}-breadcrumbs__link-wrapper" do
                  BREADCRUMB_DIVIDER_SVG + link_to(breadcrumb[:label], breadcrumb[:path],
                                                   class: "#{brand}-breadcrumbs__link",
                                                   'aria-current': is_current_page ? 'page' : nil)
                end
              end
            end
          end

          def root_path_breadcrumb(breadcrumb)
            content_tag :div, class: "#{brand}-breadcrumbs__link-wrapper--home" do
              link_to breadcrumb[:path], class: "#{brand}-breadcrumbs__link--home" do
                BREADCRUMB_HOME_SVG + content_tag(:span, breadcrumb[:label], class: 'sr-only')
              end
            end
          end
        end
      end
    end
  end
end
