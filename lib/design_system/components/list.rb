# frozen_string_literal: true

module DesignSystem
  module Components
    # Simple list component used by the generic list builder.
    class List
      attr_reader :items

      def initialize
        @items = []
      end

      def add_item(content = nil, &block)
        @items << (block_given? ? block : content)
      end
    end
  end
end
