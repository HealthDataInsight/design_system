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

          content_tag(:dl) do
            render_rows
          end
        end

        private

        def render_rows
          @summary_list.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
            rows_buffer.concat(content_tag(:div)) do
              row_buffer = ActiveSupport::SafeBuffer.new

              row_buffer.concat(content_tag(:dt), row[:key][:content])

              row_buffer.concat(content_tag(:dd), row[:value][:content])

              if row[:actions].any?
                actions_buffer = row[:actions].each_with_object(ActiveSupport::SafeBuffer.new) do |action, acc|
                  acc.concat(content_tag(:li), action[:content], action[:options])
                end
                row_buffer.concat(content_tag(:dd), class: 'actions') do
                  content_tag(:ul, actions_buffer, class: 'actions-list')
                end
              end

              row_buffer
            end
          end
        end
      end
    end
  end
end
