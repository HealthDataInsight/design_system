# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This builds a generic details component with brand-specific classes
      class Details < Base
        def render_details(summary_text)
          content = capture { yield if block_given? }

          content_tag(:details, class: "#{brand}-details") do
            safe_buffer = ActiveSupport::SafeBuffer.new

            safe_buffer.concat(
              content_tag(:summary, class: "#{brand}-details__summary") do
                content_tag(:span, summary_text, class: "#{brand}-details__summary-text")
              end
            )

            safe_buffer.concat(
              content_tag(:div, content, class: "#{brand}-details__text")
            )

            safe_buffer
          end
        end
      end
    end
  end
end
