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
            raise ArgumentError, 'A mix of rows with and without actions is not supported for NHS brand.'
          end
        end

        def render_rows
          validate_mix_actions

          content_tag(:dl, class: 'nhsuk-summary-list') do
            @summary_list.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
              rows_buffer.concat(render_row(row))
            end
          end
        end

        def render_actions(row)
          content_tag(:dd, class: 'nhsuk-summary-list__actions') do
            if row[:actions].length == 1
              render_action(row[:actions].first)
            else
              content_tag(:ul, class: 'nhsuk-summary-list__actions-list') do
                row[:actions].each_with_object(ActiveSupport::SafeBuffer.new) do |action, actions_buffer|
                  actions_buffer.concat(content_tag(:li, render_action(action),
                                                    class: 'nhsuk-summary-list__actions-list-item'))
                end
              end
            end
          end
        end

        def render_action(action)
          content_tag(:a, href: action[:options][:path] || '#') do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(action[:content])

            if action[:options][:hidden_text]
              safe_buffer.concat(content_tag(:span, action[:options][:hidden_text], class: 'nhsuk-u-visually-hidden'))
            end

            safe_buffer
          end
        end
      end
    end
  end
end
