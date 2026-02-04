# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display notifications.
      class Notification < Base
        include ActionView::Helpers::SanitizeHelper

        def render_alert(msg = nil, &)
          content_to_display = block_given? ? capture(&) : msg
          content_tag(:div, class: "#{brand}-error-summary", 'aria-labelledby': 'error-summary-title', role: 'alert',
                            tabindex: '-1') do
            content_tag(:h2, content_to_display,
                        class: "#{brand}-error-summary__title", id: 'error-summary-title')
          end
        end

        def render_notice(msg = nil, header: nil, type: :information, &)
          @context.instance_variable_set(:@link_context, :notification_banner)

          raise ArgumentError,
                "Invalid notification type: #{type}. Must be one of: #{notification_type_hash.keys.join(', ')}" unless notification_type_hash.key?(type)

          header ||= notification_type_hash.dig(type, :header)

          content_to_display = block_given? ? capture(&) : msg
          content_tag(:div, class: notification_type_hash.dig(type, :class), role: notification_type_hash.dig(type, :role),
                            'aria-labelledby': "#{brand}-notification-banner-title",
                            'data-module': "#{brand}-notification-banner") do
            banner_tile(header) + banner_content(content_to_display)
          end
        end

        private

        def banner_tile(header)
          content_tag(:div, class: "#{brand}-notification-banner__header") do
            content_tag(:h2, header, class: "#{brand}-notification-banner__title",
                                     id: "#{brand}-notification-banner-title")
          end
        end

        def banner_content(content)
          content_tag(:div, class: "#{brand}-notification-banner__content") do
            content_tag(:p, content,
                        class: "#{brand}-notification-banner__heading")
          end
        end

        def notification_type_hash
          {
            information: {
              header: 'Important',
              class: "#{brand}-notification-banner",
              role: 'region'
            },
            success: {
              header: 'Success',
              class: "#{brand}-notification-banner #{brand}-notification-banner--success",
              role: 'alert'
            }
          }
        end
      end
    end
  end
end
