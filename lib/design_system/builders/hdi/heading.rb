# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides Hdi methods to display headings in page content.
      class Heading < ::DesignSystem::Builders::Generic::Heading
        SIZE_MAPPING = {
          1 => 'text-3xl sm:text-4xl font-bold',
          2 => 'text-xl sm:text-2xl font-semibold',
          3 => 'text-lg sm:text-xl font-semibold',
          4 => 'text-base sm:text-lg font-semibold',
          5 => 'text-sm sm:text-base font-semibold',
          6 => 'text-sm sm:text-s font-semibold'
        }.freeze

        private

        def classes(level)
          level = level.to_i
          validate_level(level)

          base_classes = 'leading-6 tracking-tight text-gray-900 mb-2 break-words '
          base_classes + SIZE_MAPPING[level]
        end
      end
    end
  end
end
