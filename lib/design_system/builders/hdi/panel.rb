# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This generates html for rendering panel for HDI using cards
      class Panel < ::DesignSystem::Builders::Generic::Panel
        def render_panel(title, body)
          safe_buffer = ActiveSupport::SafeBuffer.new
          content_tag(:div, class: 'card card-border card-lg bg-base-100 w-96') do
            safe_buffer.concat(content_tag(:div, '', class: 'card-body'))
            safe_buffer.concat(content_tag(:h1, title, class: 'text-3xl sm:text-4xl font-bold'))
            safe_buffer.concat(content_tag(:p, body))
          end
        end
      end
    end
  end
end
