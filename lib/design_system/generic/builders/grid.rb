# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      class Grid < Base
        include ActionView::Helpers::OutputSafetyHelper

        def render_grid_row(options = {})
          @grid = ::DesignSystem::Components::Grid.new
          yield @grid

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
          width_name = case width
                       when :full then 'full'
                       when :one_half then 'one-half'
                       when :two_thirds then 'two-thirds'
                       when :one_third then 'one-third'
                       when :three_quarters then 'three-quarters'
                       when :one_quarter then 'one-quarter'
                       else
                         width.to_s.tr('_', '-')
                       end

          "#{brand}-grid-column-#{width_name}"
        end
      end
    end
  end
end
