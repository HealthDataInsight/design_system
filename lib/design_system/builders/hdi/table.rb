module DesignSystem
  module Builders
    module Hdi
      # This concern is used to provide HDI Table.
      module Table
        extend ActiveSupport::Concern

        private

        def render_table
          content_tag(:table, nil, class: 'min-w-full divide-y divide-gray-300') do
            safe_buffer = ActiveSupport::SafeBuffer.new

            safe_buffer.concat(content_tag(:caption, @table.caption, class: 'caption_top')) if @table.caption

            safe_buffer.concat(table_heading(headings: @table.headings)) unless @table.headings.empty?

            safe_buffer.concat(
              content_tag(:tbody, class: 'divide-y divide-gray-200') do
                content_table_body
              end
            )
            safe_buffer
          end
        end

        def table_heading(headings: [])
          content_tag(:thead) do
            content_tag(:tr) do
              headings.each_with_object(ActiveSupport::SafeBuffer.new) do |heading, safe_buffer|
                safe_buffer.concat(
                  content_tag(:th, heading, scope: 'col',
                                            class: 'px-3 py-3.5 text-left text-sm font-semibold text-gray-900')
                )
              end
            end
          end
        end

        def content_for_row(row)
          content_tag(:tr) do
            row.each_with_object(ActiveSupport::SafeBuffer.new) do |col, safe_buffer|
              safe_buffer.concat(content_tag(:td, col, class: 'whitespace-nowrap px-3 py-4 text-sm text-gray-500'))
            end
          end
        end

        def content_for_numeric_row(row)
          content_for_row(row)
        end
      end
    end
  end
end
