# frozen_string_literal: true

require 'design_system/components/table'
require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      # This class is used to provide table builder.
      class Table < Base
        def render_table(options = {})
          @table = ::DesignSystem::Components::Table.new
          yield @table

          content_tag(:div, **options) do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(table_content)

            safe_buffer
          end
        end

        private

        def table_content
          content_tag :table do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(content_tag(:caption, @table.caption)) if @table.caption
            safe_buffer.concat(render_headers)
            safe_buffer.concat(render_rows)
            safe_buffer
          end
        end

        def render_headers
          content_tag :thead do
            content_tag :tr do
              @table.columns.each_with_object(ActiveSupport::SafeBuffer.new) do |header, header_buffer|
                options = cell_numeric?(header) ? header[:options].merge(align: 'right') : header[:options]
                header_buffer.concat(content_tag(:th, header[:content], options))
              end
            end
          end
        end

        def render_rows
          content_tag :tbody do
            @table.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
              rows_buffer.concat(content_tag(:tr) do
                row.each_with_object(ActiveSupport::SafeBuffer.new) do |cell, cell_buffer|
                  options = cell_numeric?(cell) ? cell[:options].merge(align: 'right') : cell[:options]
                  cell_buffer.concat(content_tag(:td, cell[:content], options))
                end
              end)
            end
          end
        end

        # This method is for table component to identify if cell is numeric type
        def cell_numeric?(cell)
          cell[:options][:type] == 'numeric'
        end
      end
    end
  end
end
