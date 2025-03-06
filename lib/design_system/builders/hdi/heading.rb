# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides Hdi methods to display headings in page content.
      class Heading < ::DesignSystem::Builders::Generic::Heading
        def render_heading(text, level: 2)
          validate_level(level)

          content_tag("h#{level}", text,
                      class: 'text-lg sm:text-2xl font-semibold leading-6 text-gray-900 mt-2 mb-2 break-words')
        end
      end
    end
  end
end
