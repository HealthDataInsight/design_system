# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This generates html for rendering callout for HDI
      class Callout < ::DesignSystem::Builders::Generic::Callout
        private

        def render_label(label)
          content_tag(:h3, class: "#{brand}-warning-callout__label") do
            content_tag(:span, role: 'text') do
              content_tag(:span, 'Important: ', class: "#{brand}-visually-hidden") + label
            end
          end
        end
      end
    end
  end
end
