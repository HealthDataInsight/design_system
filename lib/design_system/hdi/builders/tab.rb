# frozen_string_literal: true

module DesignSystem
  module Hdi
    module Builders
      # This class provides methods to render HDI tab.
      class Tab < ::DesignSystem::Generic::Builders::Tab
        def render_tabs
          @tab = ::DesignSystem::Components::Tab.new

          yield @tab
          content_tag(:div, class: 'mb-4 border-b border-gray-200 dark:border-gray-700') do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(tabs_list_content) if @tab.tabs.present?
            safe_buffer.concat(tabs_body_content) if @tab.tabs.present?
            safe_buffer
          end
        end

        private

        def tabs_list_content
          content_tag(:ul, class: 'flex flex-wrap -mb-px text-sm font-medium text-center', id: 'default-tab',
                           'data-tabs-toggle': '#default-tab-content', role: 'tablist') do
            @tab.tabs.each_with_object(ActiveSupport::SafeBuffer.new) do |(name, _content, id, sel), link_buffer|
              link_buffer.concat(
                content_tag(:li, class: 'me-2', role: 'presentation') do
                  content_tag(:button, name, class: tab_button_class(sel), id: "#{id}-tab",
                                             'data-tabs-target': "##{id}", type: 'button',
                                             role: 'tab', 'aria-selected': sel.to_s, 'aria-controls': id.to_s)
                end
              )
            end
          end
        end

        def tabs_body_content
          content_tag(:div, id: 'default-tab-content') do
            @tab.tabs.each_with_object(ActiveSupport::SafeBuffer.new) do |(_name, content, id, _sel), body_buffer|
              style = 'hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800'
              body_buffer.concat(
                content_tag(:div, class: style, id:, role: 'tabpanel', 'aria-labelledby': "#{id}-tab") do
                  content_tag(:p, content, class: 'text-sm text-gray-500 dark:text-gray-400')
                end
              )
              body_buffer
            end
          end
        end

        def tab_button_class(selected)
          if selected
            'inline-block py-2 px-4 text-blue-600 border-b-2 border-blue-600 rounded-t-lg'
          else
            'inline-block p-4 border-b-2 rounded-t-lg hover:text-gray-600 hover:border-gray-300
             dark:hover:text-gray-300'
          end
        end
      end
    end
  end
end
