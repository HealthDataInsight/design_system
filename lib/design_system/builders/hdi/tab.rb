# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides methods to render HDI tab.
      class Tab < ::DesignSystem::Builders::Generic::Tab
        def render_tabs
          @tab = ::DesignSystem::Components::Tab.new

          yield @tab
          content_tag(:div, class: "#{brand}-tabs", data: { controller: 'tabs' }) do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(tabs_list_content) if @tab.tabs.present?
            safe_buffer.concat(tabs_body_content) if @tab.tabs.present?
            safe_buffer
          end
        end

        private

        def tabs_list_content
          content_tag(:ul, class: "#{brand}-tabs__list", id: 'default-tab',
                           'data-tabs-toggle': '#default-tab-content', role: 'tablist') do
            @tab.tabs.each_with_object(ActiveSupport::SafeBuffer.new) do |(name, _content, id, sel), link_buffer|
              link_buffer.concat(
                content_tag(:li, class: "#{brand}-tabs__list-item", role: 'presentation') do
                  content_tag(:button, name, class: tab_button_class(sel), id: "#{id}-tab", type: 'button',
                                             role: 'tab', 'aria-selected': sel.to_s, 'aria-controls': id.to_s, data: { tabs_target: 'tabButton', action: 'tabs#show' })
                end
              )
            end
          end
        end

        def tabs_body_content
          content_tag(:div, id: 'default-tab-content') do
            @tab.tabs.each_with_object(ActiveSupport::SafeBuffer.new) do |(_name, content, id, _sel), body_buffer|
              style = "#{brand}-tabs__panel #{brand}-tabs__panel--hidden"
              body_buffer.concat(
                content_tag(:div, class: style, id:, role: 'tabpanel', 'aria-labelledby': "#{id}-tab",
                                  data: { tabs_target: 'tabPanel' }) do
                  content_tag(:p, content, class: "#{brand}-tabs__panel-content")
                end
              )
              body_buffer
            end
          end
        end

        def tab_button_class(selected)
          if selected
            "#{brand}-tabs__tab #{brand}-tabs__tab--selected"
          else
            "#{brand}-tabs__tab"
          end
        end
      end
    end
  end
end
