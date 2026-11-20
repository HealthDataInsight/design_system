# frozen_string_literal: true

module DesignSystem
  module Components
    # This class provides a summary list component.
    class SummaryList
      attr_accessor :rows

      def initialize
        @rows = []
      end

      # Add a new row to the summary list.
      # Use this method to add rows containing single key-value pair
      def add_row(*args, key: nil, value: nil)
        key, value = args if args.any?

        row_builder = SummaryListRowBuilder.new
        row_builder.add_key(key) if key
        row_builder.add_value(value) if value

        yield(row_builder) if block_given?
        @rows << row_builder.row
      end
    end

    # This class provides a builder for a summary list row.
    class SummaryListRowBuilder
      attr_reader :row

      def initialize
        @row = {
          key: {},
          values: [],
          actions: [],
          widths: {}
        }
      end

      # Required element for a row in the summary list.
      # Pass width: (a Grid::WIDTHS key, e.g. :one_third) to size the key column.
      def add_key(content, options = {})
        @row[:key] = { content: content.to_s, options: extract_width(:key, options) }
      end

      # Use this method to add multiple values in a single row.
      # Pass width: to size the value column.
      def add_value(content, options = {})
        @row[:values] << { content: content.to_s, options: extract_width(:value, options) }
      end

      # Use this method to add an action to a row and add link via options hash.
      # Pass width: to size the actions column (applies to the whole column, not just this action).
      def add_action(content, options = {})
        @row[:actions] << { content: content.to_s, options: extract_width(:actions, options) }
      end

      private

      def extract_width(column, options)
        options = options.dup
        width = options.delete(:width)
        return options unless width

        raise ArgumentError, "Unknown summary list width: #{width}" unless Grid::WIDTHS.key?(width)

        @row[:widths][column] = width
        options
      end
    end
  end
end
