# frozen_string_literal: true

require 'design_system/components/summary_list'
require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      class SummaryList < Base
        def render_summary_list
          @summary_list = ::DesignSystem::Components::SummaryList.new
          yield @summary_list

          safe_buffer = ActiveSupport::SafeBuffer.new
          safe_buffer.concat(render_rows)

          safe_buffer
        end

        private

        def render_rows
          content_tag(:dl, class: "#{brand}-summary-list") do
            @summary_list.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
              rows_buffer.concat(render_row(row))
            end
          end
        end

        def render_row(row)
          content_tag(:div, class: "#{brand}-summary-list__row") do
            row_buffer = ActiveSupport::SafeBuffer.new

            row_buffer.concat(render_key(row))
            row_buffer.concat(render_value(row))
            row_buffer.concat(render_actions(row)) if row[:actions].any?

            row_buffer
          end
        end

        def render_key(row)
          content_tag(:dt, row[:key][:content], class: "#{brand}-summary-list__key")
        end

        def render_value(row)
          content_tag(:dd, row[:value][:content], class: "#{brand}-summary-list__value")
        end

        def render_actions(row)
          content_tag(:dd, class: "#{brand}-summary-list__actions") do
            if row[:actions].length == 1
              render_action(row[:actions].first)
            else
              content_tag(:ul, class: "#{brand}-summary-list__actions-list") do
                row[:actions].each_with_object(ActiveSupport::SafeBuffer.new) do |action, actions_buffer|
                  actions_buffer.concat(content_tag(:li, render_action(action),
                                                    class: "#{brand}-summary-list__actions-list-item"))
                end
              end
            end
          end
        end

        def render_action(action)
          content_tag(:a, action[:content], href: action[:options][:path] || '#')
        end
      end
    end
  end
end
