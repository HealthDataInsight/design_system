# frozen_string_literal: true

require 'design_system/builders/generic/summary_list'

module DesignSystem
  module Builders
    module Nhsuk
      class SummaryList < ::DesignSystem::Builders::Generic::SummaryList
        private

        def validate_mix_actions
          if @summary_list.rows.any? { |row| row[:actions].empty? } &&
             @summary_list.rows.any? { |row| row[:actions].any? }
            raise ArgumentError, "A mix of rows with and without actions is not supported for #{brand} style."
          end
        end

        def render_rows
          validate_mix_actions

          content_tag(:dl, class: "#{brand}-summary-list") do
            @summary_list.rows.map { |row| render_row(row) }.join.html_safe
          end
        end

        def render_hidden_text(hidden_text)
          return '' if hidden_text.blank?

          content_tag(:span, hidden_text, class: "#{brand}-u-visually-hidden")
        end
      end
    end
  end
end
