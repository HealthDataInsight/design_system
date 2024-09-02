# frozen_string_literal: true

module DesignSystem
  module Components
    # This is the class to define table component structure
    class Table
      attr_accessor :caption, :headers, :rows

      def initialize
        @headers = []
        @rows = []
      end

      def add_header(&block)
        header_builder = HeaderBuilder.new
        block.call(header_builder)
        @headers << header_builder.cells
      end

      def add_row(&block)
        row_builder = RowBuilder.new
        block.call(row_builder)
        @rows << row_builder.cells
      end
    end

    # This class helps in building the header for the table <th>
    class HeaderBuilder
      attr_reader :cells

      def initialize
        @cells = []
      end

      def add_cell(content, options = {})
        @cells << { content:, options: }
      end

      def add_numeric_cell(content, options = {})
        default_options = { type: 'numeric' }
        @cells << { content:, options: default_options.merge(options) }
      end
    end

    # This class helps in building the row for the table <tr>
    class RowBuilder
      attr_reader :cells

      def initialize
        @cells = []
      end

      def add_cell(content, options = {})
        @cells << { content:, options: }
      end

      def add_numeric_cell(content, options = {})
        default_options = { type: 'numeric' }
        @cells << { content:, options: default_options.merge(options) }
      end
    end
  end
end
