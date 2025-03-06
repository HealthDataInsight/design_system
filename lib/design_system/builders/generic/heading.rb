# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display headings in page content.
      class Heading < Base
        def render_heading(text, level: 2, caption: nil)
          validate_level(level)

          content = caption ? "#{content_tag(:span, caption, class: "#{brand}-caption-m")} #{text}".html_safe : text
          content_tag("h#{level}", content, class: "#{brand}-heading-l")
        end

        private

        def validate_level(level)
          level = level.to_i
          raise ArgumentError, "Invalid heading levle #{level}. Must be an integer between 1 and 6." unless level in (1..6)
        end
      end
    end
  end
end
