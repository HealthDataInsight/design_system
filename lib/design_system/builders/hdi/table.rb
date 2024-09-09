# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This concern is used to provide HDI Table.
      module Table
        extend ActiveSupport::Concern

        private

        def render_table
          content_tag(:table, class: 'min-w-full divide-y divide-gray-300') do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(content_tag(:caption, @table.caption, class: 'caption_top')) if @table.caption
            safe_buffer.concat(render_headers)
            safe_buffer.concat(render_rows)
            safe_buffer
          end
        end

        def render_headers
          content_tag(:thead) do
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
          content_tag(:tr) do
            row.each_with_object(ActiveSupport::SafeBuffer.new) do |cell, cell_buffer|
              cell_buffer.concat(
                content_tag(:td, cell[:content],
                            cell[:options].merge(class: 'whitespace-nowrap px-3 py-4 text-sm text-gray-500'))
              )
            end
          end
        end
      end
    end
  end
end
