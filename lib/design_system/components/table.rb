# frozen_string_literal: true

module DesignSystem
  module Components
    # This is the class to define table component structure
    class Table
      attr_accessor :caption, :columns, :rows

      def initialize
        @columns = []
        @rows = []
      end

      def add_column(content, options = {})
        @columns << { content:, options: }
      end

      def add_numeric_column(content, options = {})
        default_options = { type: 'numeric' }
        @columns << { content:, options: default_options.merge(options) }
      end

      def add_row(*cells, &block)
        if block_given?
          row_builder = TableRowBuilder.new(@columns)
          block.call(row_builder)
          @rows << row_builder.cells
        else
          row = cells.map.with_index do |content, i|
            options = @columns[i][:options][:type] == 'numeric' ? { type: 'numeric' } : {}
            { content:, options: }
          end
          @rows << row
        end
      end
    end

    # This class helps in building the row for the table <tr>
    class TableRowBuilder
      attr_reader :cells

      def initialize(columns)
        @cells = []
        @columns = columns
      end

      def add_cell(content = nil, options = {}, &block)
        if block_given?
          options = content || {}
          content = block
        end

        index = @cells.size
        if @columns[index][:options][:type] == 'numeric'
          default_options = { type: 'numeric' }
          options = default_options.merge(options)
        end
        @cells << { content:, options: }
      end
    end
  end
end
