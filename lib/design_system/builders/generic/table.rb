# frozen_string_literal: true

require 'design_system/components/table'
require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      # This class is used to provide table builder.
      class Table < Base
        def render_table
          @table = ::DesignSystem::Components::Table.new
          yield @table

          content_tag(:div) do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(table_content)

            safe_buffer
          end
        end

        private

        def table_content
          content_tag :table do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(render_headers)
            safe_buffer.concat(render_rows)
            safe_buffer
          end
        end

        def render_headers
          content_tag :thead do
            content_tag :tr do
              @table.columns.each_with_object(ActiveSupport::SafeBuffer.new) do |header, header_buffer|
                header_buffer.concat(content_tag(:th, header[:content], header[:options]))
              end
            end
          end
        end

        def render_rows
          content_tag :tbody do
            @table.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
              rows_buffer.concat(content_tag(:tr) do
                row.each_with_object(ActiveSupport::SafeBuffer.new) do |cell, cell_buffer|
                  cell_buffer.concat(content_tag(:td, cell[:content], cell[:options]))
                end
              end)
            end
          end
        end
      end
    end
  end
end
