module DesignSystem
  module Govuk
    # GOV.UK summary list: a single value renders inline (plain text or a
    # link); only multi-value rows wrap each entry in a govuk-body paragraph.
    class SummaryListComponent < DesignSystem::Generic::SummaryListComponent
      private

      def render_value(row)
        content_tag(:dd, class: 'govuk-summary-list__value') do
          if row[:values].blank?
            ''
          elsif row[:values].length == 1
            wrap_value(row[:values].first)
          else
            safe_join(row[:values].map { |value| wrap_value(value, paragraph: true) })
          end
        end
      end

      def wrap_value(value, paragraph: false)
        if value[:options]&.dig(:path)
          link_to(value[:content], value[:options][:path] || '#', class: 'govuk-link')
        elsif paragraph
          content_tag(:p, value[:content], class: 'govuk-body')
        else
          value[:content]
        end
      end
    end
  end
end
