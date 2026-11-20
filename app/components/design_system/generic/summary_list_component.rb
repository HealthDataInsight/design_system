module DesignSystem
  module Generic
    # Summary list (dl) rendered by ds_summary_list. Each row has a key, one
    # or more values, and optional actions. Brands override paragraph class
    # and hidden text via subclasses.
    class SummaryListComponent < DesignSystem::BaseComponent
      def initialize(summary_list:)
        super()
        @summary_list = summary_list
      end

      attr_reader :summary_list

      def value_content(row)
        if row[:values].blank?
          ''
        elsif row[:values].length == 1
          wrap_value(row[:values].first)
        else
          safe_join(row[:values].map { |value| wrap_value(value, paragraph: true) })
        end
      end

      # Column (key, value or actions) class, plus a width utility class if one was set.
      def column_class(row, column)
        width = row.dig(:widths, column)
        classes = ["#{brand}-summary-list__#{column}"]
        classes << width_class(::DesignSystem::Components::Grid::WIDTHS[width][:class]) if width
        classes.join(' ')
      end

      def render_action(action)
        options = action[:options].dup
        path = options.delete(:path) || '#'
        hidden_text = options.delete(:hidden_text)

        link_to(path, { class: "#{brand}-link" }.merge(options)) do
          safe_join([action[:content], render_hidden_text(hidden_text)])
        end
      end

      def wrap_value(value, paragraph: false)
        content = if value[:options]&.dig(:path)
                    link_to(value[:content], value[:options][:path] || '#', class: "#{brand}-link")
                  else
                    value[:content]
                  end

        return content unless paragraph

        content_tag(:p, content, class: value_paragraph_class)
      end

      private

      # Width utilities, not grid-column classes: those float, which breaks the table-cell layout.
      def width_class(width)
        "#{brand}-!-width-#{width}"
      end

      def value_paragraph_class
        "#{brand}-body"
      end

      def render_hidden_text(hidden_text)
        return '' if hidden_text.blank?

        content_tag(:span, hidden_text, class: "#{brand}-visually-hidden")
      end
    end
  end
end
