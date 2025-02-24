# frozen_string_literal: true

require 'design_system/builders/generic/summary_list'

module DesignSystem
  module Builders
    module Govuk
      class SummaryList < ::DesignSystem::Builders::Generic::SummaryList
        def render_rows
          content_tag(:dl, nil, class: "#{brand}-summary-list") do
            @summary_list.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
              rows_buffer.concat(render_row(row))
            end
          end
        end

        private

        def render_row(row)
          content_tag(:div, class: "#{brand}-summary-list__row") do
            row_buffer = ActiveSupport::SafeBuffer.new

            row_buffer.concat(content_tag(:dt, row[:key][:content], class: "#{brand}-summary-list__key"))
            row_buffer.concat(content_tag(:dd, row[:value][:content], class: "#{brand}-summary-list__value"))

            # TODO: add actions
          end
        end
      end
    end
  end
end
