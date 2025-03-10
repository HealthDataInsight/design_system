# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides Hdi methods to display headings in page content.
      class Heading < ::DesignSystem::Builders::Generic::Heading
        private

        def classes(level)
          validate_level(level)

          base_classes = 'leading-6 tracking-tight text-gray-900 mb-2 break-words '

          case level
          when 1 then base_classes + 'text-3xl sm:text-4xl font-bold'
          when 2 then base_classes + 'text-xl sm:text-2xl font-semibold'
          when 3 then base_classes + 'text-lg sm:text-xl font-semibold'
          when 4 then base_classes + 'text-base sm:text-lg font-semibold'
          else
            base_classes + 'text-sm sm:text-base font-semibold'
          end
        end
      end
    end
  end
end
