# frozen_string_literal: true

module DesignSystem
  module Components
    class SummaryList
      attr_accessor :rows

      def initialize
        @rows = []
      end

      # Add a new row to the summary list.
      # Use this method to add rows containing single key-value pair
      def add_row(key: nil, value: nil, options: {}, &block)
        row_builder = SummaryListRowBuilder.new

        row_builder.add_key(key) if key
        row_builder.add_value(value) if value

        yield(row_builder) if block_given?
        @rows << row_builder.row
      end
    end

    class SummaryListRowBuilder
      attr_reader :row

      def initialize
        @row = {
          key: {},
          values: [],
          actions: []
        }
      end

      # Required element for a row in the summary list
      def add_key(content, options = {})
        @row[:key] = { content: content.to_s, options: }
      end

      # Use this method to add multiple values in a single row
      def add_value(content, options = {})
        @row[:values] << { content: content.to_s, options: }
      end

      # Use this method to add an action to a row and add link via options hash
      def add_action(content, options = {})
        @row[:actions] << { content: content.to_s, options: }
      end
    end
  end
end
