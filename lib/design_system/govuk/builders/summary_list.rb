# frozen_string_literal: true

module DesignSystem
  module Govuk
    module Builders
      # This class provides GOVUK Summary List.
      class SummaryList < ::DesignSystem::Generic::Builders::SummaryList
        private

        def render_value(row)
          content_tag(:dd, class: 'govuk-summary-list__value') do
            if row[:values].blank?
              ''
            elsif row[:values].length == 1
              wrap_value(row[:values].first)
            else
              row[:values].map { |value| wrap_value(value, paragraph: true) }.join.html_safe
            end
          end
        end

        # A single value renders inline (plain text or a link) to match the
        # GOV.UK summary list; only multi-value rows wrap each entry in a
        # govuk-body paragraph.
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
end
