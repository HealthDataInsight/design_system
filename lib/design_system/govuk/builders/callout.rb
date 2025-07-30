# frozen_string_literal: true

module DesignSystem
  module Govuk
    module Builders
      # This generates html for rendering warning callout for Govuk
      class Callout < ::DesignSystem::Generic::Builders::Callout
        def render_callout(label, body)
          safe_buffer = ActiveSupport::SafeBuffer.new
          content_tag(:div, class: "#{brand}-warning-text") do
            safe_buffer.concat(content_tag(:span, '!', class: "#{brand}-warning-text__icon", 'aria-hidden': 'true'))
            safe_buffer.concat(render_body(label, body))
          end
        end

        private

        def render_body(label, body)
          content_tag(:strong, class: "#{brand}-warning-text__text") do
            content_tag(:span, 'Warning', class: "#{brand}-visually-hidden") + label + ' ' + body
          end
        end
      end
    end
  end
end
