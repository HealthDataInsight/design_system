# frozen_string_literal: true

module DesignSystem
  module Builders
    module Nhsuk
      # This class is used to provide Nhsuk Table.
      class Table < ::DesignSystem::Builders::Govuk::Table
        private

        def table_content
          content_tag(:table, nil, class: "#{brand}-table-responsive") do
            safe_buffer = ActiveSupport::SafeBuffer.new

            if @table.caption
              safe_buffer.concat(content_tag(:caption, @table.caption,
                                             class: "#{brand}-table__caption"))
            end
            safe_buffer.concat(render_headers)
            safe_buffer.concat(render_rows)

            safe_buffer
          end
        end

        def render_headers
          content_tag(:thead, role: 'rowgroup', class: "#{brand}-table__head") do
            content_tag(:tr, role: 'row') do
              @table.columns.each_with_object(ActiveSupport::SafeBuffer.new) do |column, header_buffer|
                header_buffer.concat(render_headers_cell(column))
              end
            end
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
              cell_buffer.concat(render_data_cell(cell, index))
            end
          end
        end

        def render_data_cell(cell, index)
          classes = "#{brand}-table__cell"
          classes += " #{brand}-table__cell--numeric" if cell_numeric?(cell)

          content_tag(:td, cell[:options].merge(class: classes), role: 'cell') do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(content_tag(:span,
                                           @table.columns[index][:content],
                                           class: "#{brand}-table-responsive__heading",
                                           aria: { hidden: true }))
            safe_buffer.concat(cell[:content].to_s)

            safe_buffer
          end
        end
      end
    end
  end
end
