# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This generates html for rendering panel for HDI using cards
      class Panel < ::DesignSystem::Builders::Generic::Panel
        def render_panel(title, body)
          # TODO: Styles will be changed from tailwind to hdi-frontend
          safe_buffer = ActiveSupport::SafeBuffer.new
          content_tag(:div,
                      class: 'block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow-sm hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700') do
            safe_buffer.concat(content_tag(:h1, title,
                                           class: 'mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white'))
            safe_buffer.concat(content_tag(:p, body, class: 'font-normal text-gray-700 dark:text-gray-400'))
          end
        end
      end
    end
  end
end
