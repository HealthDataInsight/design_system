# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides methods to render HDI button.
      class Button < ::DesignSystem::Builders::Generic::Button
        def render_button(text, style, options)
          safe_buffer = ActiveSupport::SafeBuffer.new
          classes = case style
                    when 'primary', 'reverse', 'start'
                      'bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-2 px-4 rounded'
                    when 'secondary'
                      'bg-white-500 hover:bg-gray-50 text-gray font-bold py-2 px-4 rounded'
                    when 'warning'
                      'bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded'
                    end

          safe_buffer.concat(content_tag(:button, text, type: 'submit', class: classes, **options))
          safe_buffer
        end

        def render_start_button(text, _href, options)
          render_button(text, 'primary', options)
        end
      end
    end
  end
end
