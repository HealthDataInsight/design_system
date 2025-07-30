# frozen_string_literal: true

module DesignSystem
  module Govuk
    module Builders
      # This generates html for rendering panel for Govuk
      class Panel < ::DesignSystem::Generic::Builders::Panel
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
