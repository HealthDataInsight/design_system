# frozen_string_literal: true

module DesignSystem
  module Builders
    module Nhsuk
      # This class provides Nhsuk notifications html.
      class Notification < ::DesignSystem::Builders::Govuk::Notification
        def render_notice(msg)
          header = content_tag(:h3, class: "#{brand}-warning-callout__label") do
            'Important'.html_safe +
              content_tag(:span, ':', class: "#{brand}-u-visually-hidden")
          end
          content = content_tag(:p, msg)
          content_tag(:div, class: "#{brand}-warning-callout") do
            header + content
          end
        end
      end
    end
  end
end
