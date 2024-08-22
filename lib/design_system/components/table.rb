module DesignSystem
  module Components
    # This is the class to define table component structure
    class Table
      attr_accessor :caption, :headings, :rows, :columns, :numeric_cols

      def initialize
        @headings = []
        @rows = []
        @columns = []
        @numeric_cols = []
      end

      def add_column_heading(heading)
        @headings << heading
      end

      def add_row(row)
        @rows << row
      end

      def add_column(column)
        @columns << column
      end

      def add_numeric_column(column)
        @numeric_cols << column
      end
    end
  end
end
