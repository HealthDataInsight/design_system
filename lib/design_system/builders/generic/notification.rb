# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display notifications.
      class Notification < Base
        def render_alert(msg)
          # rubocop:disable Rails/OutputSafety
          content_tag(:div, class: "#{brand}-error-summary", 'aria-labelledby': 'error-summary-title', role: 'alert',
                            tabindex: '-1') do
            content_tag(:h2, msg.html_safe, class: "#{brand}-error-summary__title", id: 'error-summary-title')
          end
          # rubocop:enable Rails/OutputSafety
        end

        def render_notice(msg)
          content_tag(:div, class: "#{brand}-notification-banner", role: 'region',
                            'aria-labelledby': "#{brand}-notification-banner-title",
                            'data-module': "#{brand}-notification-banner") do
            banner_tile + banner_content(msg)
          end
        end

        private

        def banner_tile
          content_tag(:div, class: "#{brand}-notification-banner__header") do
            content_tag(:h2, 'Important', class: "#{brand}-notification-banner__title",
                                          id: "#{brand}-notification-banner-title")
          end
        end

        def banner_content(msg)
          # rubocop:disable Rails/OutputSafety
          content_tag(:div, class: "#{brand}-notification-banner__content") do
            content_tag(:p, msg.html_safe, class: "#{brand}-notification-banner__heading")
          end
          # rubocop:enable Rails/OutputSafety
        end
      end
    end
  end
end
