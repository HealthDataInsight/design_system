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
          # Unique id per instance so multiple alerts on one page keep valid,
          # non-duplicated aria-labelledby references.
          title_id = "error-summary-title-#{SecureRandom.hex(4)}"
          content_tag(:div, class: "#{brand}-error-summary", 'aria-labelledby': title_id, role: 'alert',
                            tabindex: '-1') do
            content_tag(:h2, content_to_display,
                        class: "#{brand}-error-summary__title", id: title_id)
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

          # Unique id per instance so multiple notices on one page keep valid,
          # non-duplicated aria-labelledby references.
          title_id = "#{brand}-notification-banner-title-#{SecureRandom.hex(4)}"
          content_tag(:div, class: notification_type_hash.dig(type, :class), role: notification_type_hash.dig(type, :role),
                            'aria-labelledby': title_id,
                            'data-module': "#{brand}-notification-banner") do
            banner_tile(header, title_id) + banner_content(content_body, content_heading:)
          end
        end

        private

        def banner_tile(header, title_id)
          content_tag(:div, class: "#{brand}-notification-banner__header") do
            content_tag(:h2, header, class: "#{brand}-notification-banner__title",
                                     id: title_id)
          end
        end

        def banner_content(content_body, content_heading: {})
          content_tag(:div, class: "#{brand}-notification-banner__content") do
            content = []

            if content_heading.present? && content_heading[:text].present?
              tag = content_heading[:tag] || :h3
              raise ArgumentError, "Invalid content_heading tag: #{tag}.}" unless tag.in?(%i[h3 p])

              content << content_tag(tag, content_heading[:text], class: "#{brand}-notification-banner__heading")
            end
            content << content_body if content_body.present?

            safe_join(content)
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
