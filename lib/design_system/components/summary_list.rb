# frozen_string_literal: true

module DesignSystem
  module Components
    class SummaryList
      attr_accessor :rows

      def initialize
        @rows = []
      end

      def add_row(key: nil, values: nil, &)
        row_builder = SummaryListRowBuilder.new

        row_builder.set_key(key) if key
        row_builder.set_value(values) if values

        yield(row_builder) if block_given?

        @rows << row_builder.to_h
      end
    end

    class SummaryListRowBuilder
      attr_reader :key, :values, :actions

      def initialize
        @key = { content: nil, options: {} }
        @values = []
        @actions = []
      end

      def set_key(content, options = {})
        @key = {
          content: content.to_s,
          options:
        }
      end

      def set_value(values, options = {})
        Array(values).each do |v|
          @values << {
            content: v.to_s,
            options: options.dup
          }
        end
      end

      def add_value(content, options = {})
        @values << {
          content: content.to_s,
          options: options.dup
        }
      end

      def add_action(content, options = {})
        @actions << {
          content: content.to_s,
          options: options.dup
        }
      end

      def to_h
        {
          key: @key,
          values: @values,
          actions: @actions
        }
      end
    end
  end
end
