module DesignSystem
  module Generic
    # Summary list (dl) rendered by ds_summary_list. Each row has a key, one
    # or more values, and optional actions. Brands override value and hidden
    # text rendering via subclasses.
    class SummaryListComponent < DesignSystem::BaseComponent
      def initialize(summary_list:)
        super()
        @summary_list = summary_list
      end

      attr_reader :summary_list

      def call
        content_tag(:dl, class: "#{brand}-summary-list") do
          safe_join(summary_list.rows.map { |row| render_row(row) })
        end
      end

      private

      def render_row(row)
        row_classes = ["#{brand}-summary-list__row"]
        row_classes << "#{brand}-summary-list__row--no-actions" if row[:actions].blank?

        content_tag(:div, class: row_classes.join(' ')) do
          safe_join([render_key(row), render_value(row), render_actions(row)].compact)
        end
      end

      def render_key(row)
        content_tag(:dt, row[:key][:content], class: "#{brand}-summary-list__key")
      end

      def render_value(row)
        content_tag(:dd, class: "#{brand}-summary-list__value") do
          if row[:values].blank?
            ''
          elsif row[:values].length == 1
            row[:values].first[:content]
          else
            safe_join(row[:values].map { |value| content_tag(:p, value[:content], class: "#{brand}-body") })
          end
        end
      end

      def render_actions(row)
        return if row[:actions].blank?

        content_tag(:dd, class: "#{brand}-summary-list__actions") do
          if row[:actions].length == 1
            render_action(row[:actions].first)
          else
            content_tag(:ul, class: "#{brand}-summary-list__actions-list") do
              safe_join(row[:actions].map do |action|
                content_tag(:li, render_action(action), class: "#{brand}-summary-list__actions-list-item")
              end)
            end
          end
        end
      end

      def render_action(action)
        options = action[:options].dup
        path = options.delete(:path) || '#'
        hidden_text = options.delete(:hidden_text)

        link_to(path, { class: "#{brand}-link" }.merge(options)) do
          safe_join([action[:content], render_hidden_text(hidden_text)])
        end
      end

      def render_hidden_text(hidden_text)
        return '' if hidden_text.blank?

        content_tag(:span, hidden_text, class: "#{brand}-visually-hidden")
      end
    end
  end
end
