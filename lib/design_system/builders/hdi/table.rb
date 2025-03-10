# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class is used to provide HDI Table.
      class Table < ::DesignSystem::Builders::Generic::Table
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
          safe_buffer = ActiveSupport::SafeBuffer.new

          safe_buffer.concat(content_tag(:table, class: 'min-w-full divide-y divide-gray-300') do
            table_buffer = ActiveSupport::SafeBuffer.new
            table_buffer.concat(content_tag(:caption, @table.caption, class: 'caption_top')) if @table.caption
            table_buffer.concat(render_headers)
            table_buffer.concat(render_rows)

            table_buffer
          end)

          safe_buffer
        end

        def render_headers
          content_tag(:thead, class: 'hidden sm:table-row-group') do
            content_tag(:tr) do
              @table.columns.each_with_object(ActiveSupport::SafeBuffer.new) do |cell, header_buffer|
                header_buffer <<
                  content_tag(:th, cell[:content],
                              cell[:options].merge(scope: 'col',
                                                   class: 'px-3 py-3.5 text-left text-sm font-semibold text-gray-900'))
              end
            end
          end
        end

        def render_rows
          content_tag(:tbody, class: 'divide-y divide-gray-200') do
            @table.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, buffer|
              buffer.concat(render_row(row))
            end
          end
        end

        def render_row(row)
          content_tag(:tr, class: 'whitespace-nowarp border-b border-gray-300 py-2') do
            row.each_with_object(ActiveSupport::SafeBuffer.new).with_index do |(cell, buffer), index|
              buffer.concat(render_data_cell(cell, index))
            end
          end
        end

        def render_data_cell(cell, index)
          content_tag(:td, class: 'flex justify-between px-3 py-4 text-sm text-gray-500 sm:table-cell') do
            buffer = ActiveSupport::SafeBuffer.new
            header_text = @table.columns[index][:content]

            buffer.concat(content_tag(:span, header_text, class: 'font-semibold text-gray-700 sm:hidden'))
            buffer.concat(cell[:content].to_s)

            buffer
          end
        end
      end
    end
  end
end
