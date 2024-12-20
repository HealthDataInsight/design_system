# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides HDI methods to display notifications.
      class Notification < ::DesignSystem::Builders::Generic::Notification
        def render_alert(msg)
          buffer = ActiveSupport::SafeBuffer.new

          buffer.concat(
            content_tag(:div, class: 'rounded-md bg-red-50 dark:bg-red-900 p-4 mb-4') do
              content_tag(:div, class: 'flex') do
                icon_alert_content + text_alert_content(msg)
              end
            end
          )
          buffer
        end

        def render_notice(msg)
          buffer = ActiveSupport::SafeBuffer.new

          buffer.concat(
            content_tag(:div, class: 'rounded-md bg-blue-50 dark:bg-blue-900 p-4 mb-4') do
              content_tag(:div, class: 'flex') do
                icon_notice_content + text_notice_content(msg)
              end
            end
          )

          buffer
        end

        private

        def icon_alert_content
          content_tag(:div, class: 'flex-shrink-0') do
            content_tag(:svg,
                        content_tag(:path, '', fill_rule: 'evenodd',
                                               d: 'M10 18a8 8 0 100-16 8 8 0 000 16zM8.28 7.22a.75.75 0 00-1.06
                                                   1.06L8.94 10l-1.72 1.72a.75.75 0 101.06 1.06L10 11.06l1.72
                                                   1.72a.75.75 0 01.06-1.06L11.06 10l1.72-1.72a.75.75 0 00-1.06-1.06L10
                                                   8.94 8.28 7.22z', clip_rule: 'evenodd'),
                        class: 'h-5 w-5 text-red-400 dark:text-red-100', viewBox: '0 0 20 20',
                        fill: 'currentColor', aria_hidden: 'true')
          end
        end

        def text_alert_content(msg)
          content_tag(:div, class: 'ml-3') do
            content_tag(:div, msg, data: { test: 'alert' }, class: 'text-sm text-red-700 dark:text-white')
          end
        end

        def icon_notice_content
          content_tag(:div, class: 'flex-shrink-0') do
            content_tag(:svg,
                        content_tag(:path, '', fill_rule: 'evenodd',
                                               d: 'M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9
                                        9a.75.75 0 000 1.5h.253a.25.25 0 01.244.304l-.459 2.066A1.75 1.75 0
                                        0010.747 15H11a.75.75 0 000-1.5h-.253a.25.25 0 01-.244-.304l.459-2.066A1.75
                                        1.75 0 009.253 9H9z', clip_rule: 'evenodd'),
                        class: 'h-5 w-5 text-blue-400 dark:text-blue-100', viewBox: '0 0 20 20',
                        fill: 'currentColor', aria_hidden: 'true')
          end
        end

        def text_notice_content(msg)
          # rubocop:disable Rails/OutputSafety
          content_tag(:div, class: 'ml-3 flex-1 md:flex md:justify-between') do
            content_tag(:p, class: 'text-sm text-blue-700 dark:text-white', 'data-test': 'notice') do
              msg.html_safe
            end
          end
          # rubocop:enable Rails/OutputSafety
        end
      end
    end
  end
end
