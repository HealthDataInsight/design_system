require_relative 'base'

module DesignSystem
  # This is the HDI branded adapter for the design system
  class Hdi < Base
    # In this instance the string is safe, because it contains known text.
    # rubocop:disable Rails/OutputSafety
    BREADCRUMB_HOME_SVG = <<~SVG.html_safe
      <svg class="h-5 w-5 flex-shrink-0" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
        <path fill-rule="evenodd" d="M9.293 2.293a1 1 0 011.414 0l7 7A1 1 0 0117 11h-1v6a1 1 0 01-1 1h-2a1 1 0 01-1-1v-3a1 1 0 00-1-1H9a1 1 0 00-1 1v3a1 1 0 01-1 1H5a1 1 0 01-1-1v-6H3a1 1 0 01-.707-1.707l7-7z" clip-rule="evenodd" />
      </svg>
    SVG
    BREADCRUMB_DIVIDER_SVG = <<~SVG.html_safe
      <svg class="h-5 w-5 flex-shrink-0 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
        <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
      </svg>
    SVG
    # rubocop:enable Rails/OutputSafety

    private

    # def render_main_container(&)
    #   content_tag(:div, class: 'mx-auto w-full', &)
    # end

    def render_main_heading
      content_tag(:h1, @main_heading, class: 'text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl')
    end

    def content_for_breadcrumbs
      content_for(:breadcrumbs) do
        content_tag(:div, class: 'max-w-lg mb-4') do
          content_tag(:nav, 'aria-label': 'Breadcrumb', class: 'flex') do
            content_tag(:ol, class: 'flex items-center space-x-4', role: 'list') do
              @breadcrumbs.each_with_object(ActiveSupport::SafeBuffer.new) do |breadcrumb, safe_buffer|
                safe_buffer.concat(render_breadcrumb(breadcrumb))
              end
            end
          end
        end
      end
    end

    def render_breadcrumb(breadcrumb)
      content_tag :li do
        if breadcrumb[:path] == @context.root_path
          content_tag :div do
            link_to breadcrumb[:path], class: 'text-gray-400 hover:text-gray-500' do
              BREADCRUMB_HOME_SVG + content_tag(:span, breadcrumb[:label], class: 'sr-only')
            end
          end
        else
          content_tag :div, class: 'flex items-center' do
            BREADCRUMB_DIVIDER_SVG + link_to(breadcrumb[:label], breadcrumb[:path],
                                             class: 'ml-4 text-sm font-medium text-gray-500 hover:text-gray-700',
                                             style: 'margin-left: 1rem', # ml-4 should work, but doesn't
                                             'aria-current': @context.current_page?(breadcrumb[:path]) ? 'page' : nil)
          end
        end
      end
    end
  end

  Registry.register(Hdi, 'hdi')
end
