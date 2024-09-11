# frozen_string_literal: true

require 'design_system/components/table'

module DesignSystem
  module Builders
    module Base
      # This class is used to provide table builder.
      class Table
        delegate :capture, :content_for, :content_tag, :link_to, :link_to_unless_current, to: :@context

        def initialize(context)
          @context = context
        end

        def brand
          self.class.name.split('::')[-2].underscore
        end

        def render_table
          @table = ::DesignSystem::Components::Table.new
          yield @table

          content_tag(:div) do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(table_content) if @table
            safe_buffer
          end
        end

        private

        def table_content
          content_tag(:table, nil, class: "#{brand}-table") do
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

        def render_rows
          content_tag(:tbody, class: "#{brand}-table__body") do
            @table.rows.each_with_object(ActiveSupport::SafeBuffer.new) do |row, rows_buffer|
              rows_buffer.concat(render_row(row))
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

        def render_header_cell(cell, scope)
          classes = "#{brand}-table__header"
          classes += " #{brand}-table__header--numeric" if cell_numeric?(cell)

          content_tag(:th, cell[:content], cell[:options].merge(scope:, class: classes))
        end

        def render_data_cell(cell)
          classes = "#{brand}-table__cell"
          classes += " #{brand}-table__cell--numeric" if cell_numeric?(cell)

          content_tag(:td, cell[:content], cell[:options].merge(class: classes))
        end

        def cell_numeric?(cell)
          cell[:options][:type] == 'numeric'
        end
      end
    end
  end
end
