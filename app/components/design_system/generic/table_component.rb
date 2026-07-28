module DesignSystem
  module Generic
    # Table rendered by ds_table. Wraps a caption, header row and body rows
    # built via the Table data object. Brands override markup via their own
    # templates; cell helpers live here for reuse.
    class TableComponent < DesignSystem::BaseComponent
      def initialize(table:, **options)
        super()
        @table = table
        @options = options
      end

      attr_reader :table, :options

      def cell_content(cell)
        if cell[:content].is_a?(Numeric)
          cell[:content].to_s
        elsif cell[:content].is_a?(Proc)
          capture(&cell[:content])
        else
          cell[:content]
        end
      end

      def cell_numeric?(cell)
        cell[:options][:type] == 'numeric'
      end

      def cell_options(cell)
        opts = cell[:options].dup
        opts = opts.merge(align: 'right') if cell_numeric?(cell)
        opts
      end

      def header_classes(cell)
        classes = "#{brand}-table__header"
        classes += " #{brand}-table__header--numeric" if cell_numeric?(cell)
        classes
      end

      def data_cell_classes(cell)
        classes = "#{brand}-table__cell"
        classes += " #{brand}-table__cell--numeric" if cell_numeric?(cell)
        classes
      end
    end
  end
end
