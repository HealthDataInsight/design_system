# frozen_string_literal: true

module DesignSystem
  module Hdi
    module Builders
      # This generates html for rendering callout for HDI
      class Callout < ::DesignSystem::Generic::Builders::Callout
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
