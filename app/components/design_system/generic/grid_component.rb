module DesignSystem
  module Generic
    # Grid row rendered by ds_grid. Wraps columns whose widths map to the
    # brand grid-column classes. The column widths are validated (total must
    # not exceed 100%) when the component is built.
    class GridComponent < DesignSystem::BaseComponent
      def initialize(grid:, **options)
        super()
        @grid = grid
        @options = options
        @grid.validate_total_width!
      end

      attr_reader :grid, :options

      def row_options
        css_class_options_merge(options, ["#{brand}-grid-row"])
      end

      def column_options(column)
        css_class_options_merge(column[:options].dup, [grid_class(column[:width])])
      end

      private

      def grid_class(width)
        "#{brand}-grid-column-#{::DesignSystem::Components::Grid::WIDTHS[width][:class]}"
      end
    end
  end
end
