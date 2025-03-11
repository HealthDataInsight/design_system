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
          content_tag(:table, class: 'min-w-full divide-y divide-gray-300') do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(content_tag(:caption, @table.caption, class: 'caption_top')) if @table.caption
            safe_buffer.concat(render_headers)
            safe_buffer.concat(render_rows)

            safe_buffer
          end
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
            @table.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, safe_buffer|
              safe_buffer.concat(render_row(row))
            end
          end
        end

        def render_row(row)
          content_tag(:tr, class: 'border-b border-gray-300 py-2') do
            row.each_with_object(ActiveSupport::SafeBuffer.new).with_index do |(cell, buffer), index|
              buffer.concat(render_data_cell(cell, index))
            end
          end
        end

        def render_data_cell(cell, index)
          content_tag(:td, class: 'flex justify-between px-3 py-4 text-sm text-gray-500 sm:table-cell') do
            safe_buffer = ActiveSupport::SafeBuffer.new
            header_text = @table.columns[index][:content]

            safe_buffer.concat(content_tag(:span, header_text, class: 'font-semibold text-gray-700 sm:hidden'))
            safe_buffer.concat(content_tag(:span, cell[:content], class: 'sm:text-left text-right'))

            safe_buffer
          end
        end
      end
    end
  end
end
