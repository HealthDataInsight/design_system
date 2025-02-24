# frozen_string_literal: true

module DesignSystem
  module Components
    class SummaryList
      attr_accessor :rows

      def initialize
        @rows = []
      end

      def add_row(key: nil, value: nil, &block)
        if block_given?
          row_builder = SummaryListRowBuilder.new
          row_builder.key(key)
          row_builder.value(value)
          yield(row_builder)
          @rows << row_builder.to_h
        else
          @rows << {
            key: { content: key, options: {} },
            value: { content: value, options: {} },
            actions: []
          }
        end
      end
    end

    class SummaryListRowBuilder
      def initialize
        @key = {}
        @value = {}
        @actions = []
      end

      def key(content, options = {})
        @key = { content:, options: }
      end

      def value(content, options = {})
        @value = { content:, options: }
      end

      def add_action(content, options = {})
        @actions << { content:, options: }
      end

      def to_h
        {
          key: @key,
          value: @value,
          actions: @actions
        }
      end
    end
  end
end
