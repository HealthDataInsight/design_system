# frozen_string_literal: true

require 'design_system/builders/generic/summary_list'

module DesignSystem
  module Builders
    module Hdi
      class SummaryList < ::DesignSystem::Builders::Generic::SummaryList
        private

        def render_rows
          content_tag(:dl, class: 'py-4 min-w-full divide-y divide-gray-300 overflow-hidden') do
            @summary_list.rows.map { |row| render_row(row) }.join.html_safe
          end
        end

        def render_row(row)
          content_tag(:div, class: 'flex-wrap px-3 py-4 sm:grid sm:grid-cols-3 sm:gap-3 sm:px-6') do
            [render_key(row),
             render_value(row),
             render_actions(row)].compact.join.html_safe
          end
        end

        def render_key(row)
          content_tag(:dt, row[:key][:content], class: 'text-sm font-semibold text-gray-900 flex items-center')
        end

        def render_value(row)
          return if row[:values].blank?

          content_tag(:dd, class: 'whitespace-nowrap text-sm text-gray-500 sm:mt-0') do
            if row[:values].length == 1
              row[:values].first[:content]
            else
              row[:values].map { |value| content_tag(:p, value[:content]) }.join.html_safe
            end
          end
        end

        def render_actions(row)
          return if row[:actions].blank?

          content_tag(:dd, class: 'flex flex-wrap justify-between items-center sm:justify-end') do
            content_tag(:ul, class: 'flex flex-wrap items-center gap-2 sm:gap-1') do
              row[:actions].map.with_index do |action, index|
                content_tag(:li,
                            render_action(action),
                            class: "inline-block #{action_item_spacing(index, row[:actions].length)}")
              end.join.html_safe
            end
          end
        end

        def render_action(action)
          link_to(action[:content],
                  action[:options][:path] || '#',
                  class: 'flex items-center text-sm font-semibold text-hdi-violet underline hover:text-indigo-600')
        end

        def action_item_spacing(index, total)
          if total == 1
            ''
          elsif index.zero?
            'pr-2 border-r border-gray-300'
          elsif index == total - 1
            'pl-2'
          else
            'px-2 border-r border-gray-300'
          end
        end
      end
    end
  end
end
