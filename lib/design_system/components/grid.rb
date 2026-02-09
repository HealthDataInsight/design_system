# frozen_string_literal: true

module DesignSystem
  module Components
    class Grid
      attr_accessor :columns

      def initialize
        @columns = []
      end

      def add_grid_column(width, options = {}, &block)
        @columns << { width:, options:, block: }
      end
    end
  end
end
