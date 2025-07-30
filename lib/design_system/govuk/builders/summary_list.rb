# frozen_string_literal: true

require 'design_system/generic/builders/summary_list'

module DesignSystem
  module Govuk
    module Builders
      class SummaryList < ::DesignSystem::Generic::Builders::SummaryList
        private

        def render_row(row)
          row_classes = ['govuk-summary-list__row']
          row_classes << 'govuk-summary-list__row--no-actions' if row[:actions].empty?

          content_tag(:div, class: row_classes.join(' ')) do
            [render_key(row),
             render_value(row),
             render_actions(row)].compact.join.html_safe
          end
        end

        def render_value(row)
          return if row[:values].nil? || row[:values].empty?

          content_tag(:dd, class: 'govuk-summary-list__value') do
            if row[:values].length == 1
              wrap_value(row[:values].first)
            else
              row[:values].map { |value| wrap_value(value) }.join.html_safe
            end
          end
        end

        def wrap_value(value)
          if value[:options]&.dig(:path)
            link_to(value[:content], value[:options][:path] || '#', class: 'govuk-link')
          else
            content_tag(:p, value[:content], class: 'govuk-body')
          end
        end
      end
    end
  end
end
