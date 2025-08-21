# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      # This class provides Nhsuk notifications html.
      class Notification < ::DesignSystem::Govuk::Builders::Notification
        def render_notice(msg)
          content = content_tag(:p, sanitize(msg, tags: %w[b p br a], attributes: %w[href target]))
          content_tag(:div, class: "#{brand}-inset-text") do
            content_tag(:span, 'Information:', class: "#{brand}-u-visually-hidden") + content
          end
        end
      end
    end
  end
end
