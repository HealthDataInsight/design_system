# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides HDI methods to display notifications.
      class Notification < ::DesignSystem::Builders::Generic::Notification
        # In this instance the string is safe, because it contains known text.
        # rubocop:disable Rails/OutputSafety
        ALERT_SVG = <<~SVG.html_safe
          <svg class="hdi-icon hdi-icon__exclamation-circle" viewBox="0 0 24 24" stroke-width="1.5">
            <path stroke-linecap="round" stroke-linejoin="round" d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" />
          </svg>
        SVG

        NOTICE_SVG = <<~SVG.html_safe
          <svg class="hdi-icon hdi-icon__information-circle" viewBox="0 0 24 24" stroke-width="1.5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9 3.75h.008v.008H12v-.008Z" />
          </svg>
        SVG
        # rubocop:enable Rails/OutputSafety

        def render_alert(msg)
          buffer = ActiveSupport::SafeBuffer.new

          buffer.concat(
            content_tag(:div, class: "#{brand}-notification-banner #{brand}-notification-banner__alert",
                              role: 'alert') do
              ALERT_SVG + text_alert_content(msg)
            end
          )
          buffer
        end

        def render_notice(msg)
          buffer = ActiveSupport::SafeBuffer.new

          buffer.concat(
            content_tag(:div, class: "#{brand}-notification-banner") do
              NOTICE_SVG + text_notice_content(msg)
            end
          )

          buffer
        end

        private

        def text_alert_content(msg)
          content_tag(:span, 'data-test': 'alert') do
            sanitize(msg, tags: %w[b p br a], attributes: %w[href targ])
          end
        end

        def text_notice_content(msg)
          content_tag(:span, 'data-test': 'notice') do
            sanitize(msg, tags: %w[b p br a], attributes: %w[href targ])
          end
        end
      end
    end
  end
end
