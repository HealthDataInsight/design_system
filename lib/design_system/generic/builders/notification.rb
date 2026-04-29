# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display notifications.
      class Notification < Base
        include ActionView::Helpers::OutputSafetyHelper
        include ActionView::Helpers::SanitizeHelper

        def render_alert(msg = nil, &)
          content_to_display = block_given? ? capture(&) : msg
          content_tag(:div, class: "#{brand}-error-summary", 'aria-labelledby': 'error-summary-title', role: 'alert',
                            tabindex: '-1') do
            content_tag(:h2, content_to_display,
                        class: "#{brand}-error-summary__title", id: 'error-summary-title')
          end
        end

        def render_notice(msg = nil, type: :information, content_heading: { text: nil, tag: :h3 }, &)
          @context.instance_variable_set(:@link_context, :notification_banner)

          unless notification_type_hash.key?(type)
            raise ArgumentError,
                  "Invalid notification type: #{type}. Must be one of: #{notification_type_hash.keys.join(', ')}"
          end

          header = notification_type_hash.dig(type, :header)

          content_body = block_given? ? capture(&) : msg

          validate_content_heading_tag!(content_heading)

          content_tag(:div, class: notification_type_hash.dig(type, :class), role: notification_type_hash.dig(type, :role),
                            'aria-labelledby': "#{brand}-notification-banner-title",
                            'data-module': "#{brand}-notification-banner") do
            banner_tile(header) + banner_content(content_heading, content_body)
          end
        end

        private

        def banner_tile(header)
          content_tag(:div, class: "#{brand}-notification-banner__header") do
            content_tag(:h2, header, class: "#{brand}-notification-banner__title",
                                     id: "#{brand}-notification-banner-title")
          end
        end

        def banner_content(content_heading, content_body)
          content_tag(:div, class: "#{brand}-notification-banner__content") do
            content = []

            if content_heading[:text].present?
              content << content_tag(content_heading[:tag], content_heading[:text],
                                     class: "#{brand}-notification-banner__heading")
            end
            content << content_body if content_body.present?

            safe_join(content)
          end
        end

        def validate_content_heading_tag!(content_heading)
          tag = content_heading&.[](:tag)
          return if tag.blank?

          allowed = %i[p h1 h2 h3 h4 h5 h6]
          return if allowed.include?(tag.to_sym)

          raise ArgumentError, "Invalid content_heading tag: #{tag}. Must be one of: #{allowed.join(', ')}"
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
