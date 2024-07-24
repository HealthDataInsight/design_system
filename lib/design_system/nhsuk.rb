require_relative 'govuk'

# Extend the design system module to include Nhsuk
module DesignSystem
  # This is the NHSUK adapter for the design system
  class Nhsuk < Govuk
    private

    # def render_main_container(&)
    #   content_tag(:div, class: "#{brand}-width-container", &)
    # end

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
      content_tag(:p, class: "#{brand}-breadcrumb__back") do
        link_to(@breadcrumbs.last[:path],
                class: "#{brand}-breadcrumb__backlink",
                'aria-current': @context.current_page?(@breadcrumbs.last[:path]) ? 'page' : nil) do
          content_tag(:span, 'Back to &nbsp;'.html_safe, class: "#{brand}-u-visually-hidden") +
            @breadcrumbs.last[:label]
        end
      end
    end

    def render_breadcrumb(breadcrumb)
      content_tag(:li, class: "#{brand}-breadcrumb__item") do
        link_to(breadcrumb[:label],
                breadcrumb[:path],
                class: "#{brand}-breadcrumb__link",
                'aria-current': @context.current_page?(breadcrumb[:path]) ? 'page' : nil)
      end
    end

    ## <thead>
    def table_heading(headings: [])
      content_tag(:thead, role: 'rowgroup', class: "#{brand}-table__head") do
        content_tag(:tr, role: 'row') do
          headings.each_with_object(ActiveSupport::SafeBuffer.new) do |heading, safe_buffer|
            safe_buffer.concat(content_tag(:th, heading, scope: 'col', class: '', role: 'columnheader'))
          end
        end
      end
    end

    ## <tbody><tr>
    def content_for_row(row)
      content_tag(:tr, nil, class: "#{brand}-table__row") do
        row.each_with_object(ActiveSupport::SafeBuffer.new) do |col, safe_buffer|
          safe_buffer.concat(content_tag(:td, col, class: "#{brand}-table__cell"))
        end
      end
    end

    def content_for_numeric_row(row)
      content_for_row(row)
    end
  end

  Registry.register(Nhsuk)
end
