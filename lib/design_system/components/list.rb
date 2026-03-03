# frozen_string_literal: true

module DesignSystem
  module Components
    # Simple list component used by the generic list builder.
    class List
      attr_accessor :items

      def initialize(context)
        @context = context
        @items = []
      end

      def add_item(content = nil, &block)
        content = block_given? ? @context.capture(&block) : content
        return if content.blank?

        @items << content
      end
    end
  end
end
