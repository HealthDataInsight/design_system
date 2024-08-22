require 'design_system/table'

module DesignSystem
  module Builders
    module Base
      # This mixin module is used to provide table builder.
      module Table
        def table
          @table = ::DesignSystem::Table.new

          yield @table
        end

        private

        def render_table
          content_tag(:table, nil, class: "#{brand}-table") do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(content_tag(:caption, @table.caption, class: "#{brand}-table__caption")) if @table.caption

            safe_buffer.concat(table_heading(headings: @table.headings)) unless @table.headings.empty?

            safe_buffer.concat(
              content_tag(:tbody, nil, class: "#{brand}-table__body") do
                content_table_body
              end
            )
            safe_buffer
          end
        end

        def content_table_body
          tbody_buffer = ActiveSupport::SafeBuffer.new
          tbody_buffer.concat(content_for_row(@table.columns)) unless @table.columns.empty?

          @table.rows.each do |row|
            tbody_buffer.concat(content_for_row(row))
          end

          tbody_buffer.concat(content_for_numeric_row(@table.numeric_cols)) unless @table.numeric_cols.empty?
          tbody_buffer
        end

        def table_heading(headings: [])
          raise 'Client must implement this table_heading'
        end

        def content_for_data
          @table.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, safe_buffer|
            safe_buffer.concat(content_for_row(row))
          end
        end

        def content_for_row(_row)
          raise 'Client must implement this content_for_row'
        end
        ###
      end
    end
  end
end
