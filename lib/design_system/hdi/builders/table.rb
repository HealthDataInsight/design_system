# frozen_string_literal: true

require 'design_system/nhsuk/builders/table'

module DesignSystem
  module Hdi
    module Builders
      # This class is used to provide HDI Table.
      class Table < ::DesignSystem::Nhsuk::Builders::Table
        def render_table(options = {})
          @table = ::DesignSystem::Components::Table.new
          yield @table

          options[:class] ||= []
          options[:class] << "#{brand}-table-container"

          content_tag(:div, **options) do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(table_content)
            safe_buffer
          end
        end

        private

        def render_headers
          content_tag(:thead, class: "#{brand}-table__head") do
            content_tag(:tr, class: "#{brand}-table__row") do
              @table.columns.each_with_object(ActiveSupport::SafeBuffer.new) do |cell, header_buffer|
                header_buffer <<
                  content_tag(:th, cell_content(cell),
                              cell[:options].merge(scope: 'col',
                                                   class: "#{brand}-table__header"))
              end
            end
          end
        end

        def render_data_cell(cell, index)
          content_tag(:td, cell[:options].merge(class: "#{brand}-table__cell")) do
            safe_buffer = ActiveSupport::SafeBuffer.new
            header_text = @table.columns[index][:content]

            safe_buffer.concat(content_tag(:span, header_text, class: "#{brand}-table-responsive__heading"))
            safe_buffer.concat(content_tag(:span, cell_content(cell), class: "#{brand}-table-responsive__cell-value"))

            safe_buffer
          end
        end
      end
    end
  end
end
