# frozen_string_literal: true

module DesignSystem
  module Builders
    module Govuk
      # This concern is used to provide GOVUK Table.
      class Table < ::DesignSystem::Builders::Generic::Table
        private

        def render_headers
          content_tag(:thead, class: "#{brand}-table__head") do
            content_tag(:tr, class: "#{brand}-table__row") do
              @table.columns.each_with_object(ActiveSupport::SafeBuffer.new) do |column, header_buffer|
                header_buffer.concat(render_header_cell(column, 'col'))
              end
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
      end
    end
  end
end
