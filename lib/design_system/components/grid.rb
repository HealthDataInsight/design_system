# frozen_string_literal: true

module DesignSystem
  module Components
    class Grid
      attr_accessor :columns

      WIDTHS = {
        full: { class: 'full', fraction: Rational(1, 1) },
        half: { class: 'one-half', fraction: Rational(1, 2) },
        one_half: { class: 'one-half', fraction: Rational(1, 2) },
        two_thirds: { class: 'two-thirds', fraction: Rational(2, 3) },
        one_third: { class: 'one-third', fraction: Rational(1, 3) },
        three_quarters: { class: 'three-quarters', fraction: Rational(3, 4) },
        quarter: { class: 'one-quarter', fraction: Rational(1, 4) },
        one_quarter: { class: 'one-quarter', fraction: Rational(1, 4) }
      }.freeze

      def initialize
        @columns = []
      end

      def add_column(width, options = {}, &block)
        @columns << { width:, options:, block: }
      end

      def validate_total_width!
        total = columns.sum { |col| width_to_fraction(col[:width]) }
        raise ArgumentError, "Total grid width exceeds 100%" if total > 1
      end

      private

      def width_to_fraction(width)
        config = WIDTHS[width]
        raise ArgumentError, "Unknown grid width: #{width}" unless config

        config[:fraction]
      end
    end
  end
end
