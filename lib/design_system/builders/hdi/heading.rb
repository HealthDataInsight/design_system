# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides Hdi methods to display headings in page content.
      class Heading < ::DesignSystem::Builders::Generic::Heading
        def render_heading(text, level: 2, caption: nil)
          validate_level(level)

          content = caption ? "#{text} #{content_tag(:span, caption, class: 'text-sm hdi-text-500')}".html_safe : text
          content_tag("h#{level}", content, class: 'text-2xl font-semibold leading-6 text-gray-900')
        end
      end
    end
  end
end
