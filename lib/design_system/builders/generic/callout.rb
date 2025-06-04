# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This generates html for rendering warning callout to help users identify and understand warning content on the page, even if they do not read the whole page.
      class Callout < Base
        def render_callout(label, body)
          safe_buffer = ActiveSupport::SafeBuffer.new
          content_tag(:div, class: "#{brand}-warning-callout") do
            safe_buffer.concat(render_label(label))
            safe_buffer.concat(content_tag(:p, body))
          end
        end

        private

        def render_label(label)
          content_tag(:h3, class: "#{brand}-warning-callout__label") do
            content_tag(:span, role: 'text') do
              content_tag(:span, 'Important: ', class: "#{brand}-u-visually-hidden") + label
            end
          end
        end
      end
    end
  end
end
