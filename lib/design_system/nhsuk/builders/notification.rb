# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      # This class provides Nhsuk notifications html.
      class Notification < ::DesignSystem::Govuk::Builders::Notification
        def render_notice(msg = nil, &)
          content_to_display = block_given? ? capture(&) : msg
          content = content_tag(:p, content_to_display)
          content_tag(:div, class: "#{brand}-inset-text") do
            content_tag(:span, 'Information:', class: "#{brand}-u-visually-hidden") + content
          end
        end
      end
    end
  end
end
