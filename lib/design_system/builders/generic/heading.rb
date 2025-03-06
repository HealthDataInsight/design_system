# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display headings in page content.
      class Heading < Base
        def render_heading(text, level: 2)
          validate_level(level)

          content_tag("h#{level}", text, class: "#{brand}-heading-l")
        end

        private

        def validate_level(level)
          level = level.to_i
          return if level in (1..6)

          raise ArgumentError,
                "Invalid heading levle #{level}. Must be an integer between 1 and 6."
        end
      end
    end
  end
end
