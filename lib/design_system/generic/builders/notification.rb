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

          if type && notification_type_hash[type].present?
            header_text, banner_class = notification_type_hash[type]
          else
            header_text, banner_class = notification_type_hash[:information]
          end

          header ||= header_text

          content_to_display = block_given? ? capture(&) : msg
          content_tag(:div, class: banner_class, role: 'region',
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
            information: ['Important', "#{brand}-notification-banner"],
            success: ['Success', "#{brand}-notification-banner #{brand}-notification-banner--success"]
          }
        end
      end
    end
  end
end
