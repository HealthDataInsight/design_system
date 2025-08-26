# frozen_string_literal: true

module DesignSystem
  module Govuk
    module Builders
      # This concern is used to provide GOVUK Table.
      class Table < ::DesignSystem::Generic::Builders::Table
        private

        def table_content
          content_tag(:table, nil, class: "#{brand}-table #{brand}-table--small-text-until-tablet") do
            safe_buffer = ActiveSupport::SafeBuffer.new

            if @table.caption
              safe_buffer.concat(content_tag(:caption, @table.caption,
                                             class: "#{brand}-table__caption #{brand}-table__caption--m"))
            end
            safe_buffer.concat(render_headers)
            safe_buffer.concat(render_rows)

            safe_buffer
          end
        end

        # brand specific <th>
        def render_headers
          content_tag(:thead, class: "#{brand}-table__head") do
            content_tag(:tr, class: "#{brand}-table__row") do
              @table.columns.each_with_object(ActiveSupport::SafeBuffer.new) do |column, header_buffer|
                header_buffer.concat(render_header_cell(column, 'col'))
              end
            end
          end
        end

        def render_header_cell(cell, scope)
          classes = "#{brand}-table__header"
          classes += " #{brand}-table__header--numeric" if cell_numeric?(cell)

          content_tag(:th, cell_content(cell), cell[:options].merge(scope:, class: classes))
        end

        # brand specific <tr>
        def render_rows
          content_tag(:tbody, class: "#{brand}-table__body") do
            @table.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
              rows_buffer.concat(render_row(row))
            end
          end
        end

        def render_row(row)
          content_tag(:tr, class: "#{brand}-table__row") do
            row.each_with_object(ActiveSupport::SafeBuffer.new).with_index do |(cell, cell_buffer), index|
              cell_buffer.concat(render_cell(cell, index, 'row'))
            end
          end
        end

        def render_cell(cell, index, scope)
          if index.zero?
            render_header_cell(cell, scope)
          else
            render_data_cell(cell)
          end
        end

        def render_data_cell(cell)
          classes = "#{brand}-table__cell"
          classes += " #{brand}-table__cell--numeric" if cell_numeric?(cell)

          content_tag(:td, cell_content(cell), cell[:options].merge(class: classes))
        end
      end
    end
  end
end
