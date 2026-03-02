# frozen_string_literal: true

module DesignSystem
  module Components
    # Simple list component used by the generic list builder.
    class List
      attr_accessor :items

      def initialize
        @items = []
      end

      def add_item(content = nil, &)
        content = block_given? ? capture(&) : content
        return if content.blank?

        @items << content
      end
    end
  end
end
