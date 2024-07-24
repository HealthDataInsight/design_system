require_relative 'base'

# This is the design system module
module DesignSystem
  # This is the GOV.UK adapter for the design system
  class Govuk < Base
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

    def table_heading(headings: [])
      content_tag(:thead, class: "#{brand}-table__head") do
        content_tag(:tr, class: "#{brand}-table__row") do
          headings.each_with_object(ActiveSupport::SafeBuffer.new) do |heading, safe_buffer|
            safe_buffer.concat(content_tag(:th, heading, scope: 'col', class: "#{brand}-table__header"))
          end
        end
      end
    end

    def content_for_row(row)
      content_tag(:tr, nil, class: "#{brand}-table__row") do
        row.each_with_object(ActiveSupport::SafeBuffer.new).with_index do |(col, safe_buffer), i|
          if i.zero?
            safe_buffer.concat(content_tag(:th, col, scope: 'row', class: "#{brand}-table__header"))
          else
            safe_buffer.concat(content_tag(:td, col, class: "#{brand}-table__cell"))
          end
        end
      end
    end

    def content_for_numeric_row(row)
      content_tag(:tr, nil, class: "#{brand}-table__row") do
        row.each_with_object(ActiveSupport::SafeBuffer.new).with_index do |(col, safe_buffer), i|
          if i.zero?
            safe_buffer.concat(content_tag(:th, col, scope: 'row',
                                                     class: "#{brand}-table__header #{brand}-table__header--numeric"))
          else
            safe_buffer.concat(content_tag(:td, col, class: "#{brand}-table__cell #{brand}-table__cell--numeric"))
          end
        end
      end
    end
  end

  Registry.register(Govuk)
end
