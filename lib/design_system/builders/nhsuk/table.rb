# frozen_string_literal: true

module DesignSystem
  module Builders
    module Nhsuk
      # This concern is used to provide GOVUK Table.
      module Table
        extend ActiveSupport::Concern

        private

        def render_headers
          content_tag(:thead, role: 'rowgroup', class: "#{brand}-table__head") do
            content_tag(:tr, role: 'row') do
              @table.headers.each_with_object(ActiveSupport::SafeBuffer.new) do |header, header_buffer|
                header_buffer.concat(render_header_cells(header))
              end
            end
          end
        end

        def render_header_cells(header)
          header.each_with_object(ActiveSupport::SafeBuffer.new) do |cell, head_buffer|
            head_buffer.concat(render_headers_cell(cell))
          end
        end

        def render_headers_cell(cell)
          classes = "#{brand}-table__header"
          classes += " #{brand}-table__header--numeric" if cell_numeric?(cell)

          content_tag(:th, cell[:content], cell[:options].merge(scope: 'col', class: classes, role: 'columnheader'))
        end

        def render_row(row)
          content_tag(:tr, role: 'row', class: "#{brand}-table__row") do
            row.each_with_object(ActiveSupport::SafeBuffer.new).with_index do |(cell, cell_buffer), index|
              cell_buffer.concat(render_cell(cell, index, 'row'))
            end
          end
        end
      end
    end
  end
end
