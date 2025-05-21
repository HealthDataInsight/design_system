# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This generates html for rendering panel to display important information when a transaction has been completed.
      class Panel < Base
        def render_panel(title, body)
          safe_buffer = ActiveSupport::SafeBuffer.new
          content_tag(:div, class: "#{brand}-panel") do
            safe_buffer.concat(content_tag(:h1, title, class: "#{brand}-panel__title"))
            safe_buffer.concat(content_tag(:div, body, class: "#{brand}-panel__body"))
          end
        end
      end
    end
  end
end
