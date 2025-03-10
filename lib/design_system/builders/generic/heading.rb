# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display headings in page content.
      class Heading < Base
        def render_heading(text, level: 2)
          content_tag("h#{level}", text, class: classes(level))
        end

        private

        def classes(level)
          validate_level(level)

          case level
          when 1 then "#{brand}-heading-xl"
          when 2 then "#{brand}-heading-l"
          when 3 then "#{brand}-heading-m"
          when 4 then "#{brand}-heading-s"
          else
            "#{brand}-heading-xs"
          end
        end

        def validate_level(level)
          unless level.to_i.between?(
            1, 6
          )
            raise ArgumentError,
                  "Invalid heading level #{level}. Must be an integer between 1 and 6."
          end
        end
      end
    end
  end
end
