# frozen_string_literal: true

require 'design_system/builders/generic/summary_list'

module DesignSystem
  module Builders
    module Hdi
      class SummaryList < ::DesignSystem::Builders::Generic::SummaryList
        private

        def render_rows
          content_tag(:dl, class: 'min-w-full divide-y divide-gray-300 overflow-hidden') do
            @summary_list.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
              rows_buffer.concat(render_row(row))
            end
          end
        end

        def render_row(row)
          content_tag(:div, class: 'flex px-3 py-4 sm:grid sm:grid-cols-3 sm:gap-3 sm:px-6') do
            row_buffer = ActiveSupport::SafeBuffer.new

            row_buffer.concat(render_key(row))
            row_buffer.concat(render_value(row))
            row_buffer.concat(render_actions(row)) if row[:actions].any?

            row_buffer
          end
        end

        def render_key(row)
          content_tag(:dt, row[:key][:content], class: 'text-sm font-semibold text-gray-900')
        end

        def render_value(row)
          content_tag(:dd, row[:value][:content],
                      class: 'whitespace-nowrap px-3 text-sm text-gray-500 sm:mt-0')
        end

        def render_actions(row)
          content_tag(:dd, class: 'flex flex-wrap items-center gap-4 flex-none') do
            row[:actions].map do |action|
              content_tag(:a, action[:content], href: action[:options][:path] || '#',
                                                class: 'text-sm font-semibold text-hdi-violet hover:underline whitespace-nowrap')
            end.join.html_safe
          end
        end

        # def render_action(action)
        #   content_tag(:a, href: action[:options][:path] || '#') do
        #     safe_buffer = ActiveSupport::SafeBuffer.new
        #     safe_buffer.concat(action[:content])

        #     safe_buffer.concat(content_tag(:span, action[:options][:hidden_text])) if action[:options][:hidden_text]

        #     safe_buffer
        #   end
        # end
      end
    end
  end
end
