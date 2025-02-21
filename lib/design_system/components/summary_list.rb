# frozen_string_literal: true

module DesignSystem
  module Components
    class SummaryList
      attr_accessor :rows

      def initialize
        @rows = []
      end

      def add_row(key: nil, value: nil, actions: [], &block)
        if block_given?
          row_builder = RowBuilder.new
          yield(row_builder)
          @rows << row_builder.to_h
        else
          @rows << {
            key: { content: key, options: {} },
            value: { content: value, options: {} },
            actions: Array(actions).map { |a| { content: a, options: {} } }
          }
        end
      end
    end

    class RowBuilder
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

      def action(content, options = {})
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
