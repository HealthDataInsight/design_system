# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display headings in page content.
      class Heading < Base
        SIZE_MAPPING = {
          1 => 'xl',
          2 => 'l',
          3 => 'm',
          4 => 's',
          5 => 'xs',
          6 => 'xs'
        }.freeze
        
        def render_heading(text, level: 2)
          content_tag("h#{level}", text, class: classes(level))
        end

        private

        def classes(level)
          level = level.to_i
          validate_level(level)

          "#{brand}-heading-#{SIZE_MAPPING[level]}"
        end

        def validate_level(level)
          return if level.between?(1, 6)

          raise ArgumentError, "Invalid heading level #{level}. Must be an integer between 1 and 6."
        end
      end
    end
  end
end
