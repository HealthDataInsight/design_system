# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides a generic grid builder.
      class Grid < Base
        include ActionView::Helpers::OutputSafetyHelper

        def render_grid(options = {})
          @grid = ::DesignSystem::Components::Grid.new
          yield @grid
          @grid.validate_total_width!

          row_options = css_class_options_merge(options, ["#{brand}-grid-row"])
          content_tag(:div, **row_options) do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(render_columns)

            safe_buffer
          end
        end

        private

        def render_columns
          @grid.columns.each_with_object(ActiveSupport::SafeBuffer.new) do |column, buffer|
            column_options = column[:options].dup
            column_class = grid_class(column[:width])
            column_options = css_class_options_merge(column_options, [column_class])

            content = capture(&column[:block]) if column[:block]
            buffer.concat(content_tag(:div, content, **column_options))
          end
        end

        def grid_class(width)
          "#{brand}-grid-column-#{::DesignSystem::Components::Grid::WIDTHS[width][:class]}"
        end
      end
    end
  end
end
