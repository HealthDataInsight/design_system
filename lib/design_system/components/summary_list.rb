# frozen_string_literal: true

module DesignSystem
  module Components
    class SummaryList
      # TODO: rename item to row and fix rowbuilder conflicts
      attr_accessor :items

      def initialize
        @items = []
      end

      def add_item(key: nil, value: nil, &block)
        if block_given?
          item_builder = ItemBuilder.new
          item_builder.key(key)
          item_builder.value(value)
          yield(item_builder)
          @items << item_builder.to_h
        else
          @items << {
            key: { content: key, options: {} },
            value: { content: value, options: {} },
            actions: []
          }
        end
      end
    end

    class ItemBuilder
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
