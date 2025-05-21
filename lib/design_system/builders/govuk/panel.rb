# frozen_string_literal: true

module DesignSystem
  module Builders
    module Govuk
      # This generates html for rendering panel for Govuk
      class Panel < ::DesignSystem::Builders::Generic::Panel
        def render_panel(title, body)
          safe_buffer = ActiveSupport::SafeBuffer.new
          content_tag(:div, class: "#{brand}-panel #{brand}-panel--confirmation") do
            safe_buffer.concat(content_tag(:h1, title, class: "#{brand}-panel__title"))
            safe_buffer.concat(content_tag(:div, body, class: "#{brand}-panel__body"))
          end
        end
      end
    end
  end
end
