# frozen_string_literal: true

require 'design_system/components/tab'
require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display tab on html.
      class Tab < Base
        def render_tabs
          @tab = ::DesignSystem::Components::Tab.new

          yield @tab
          content_tag(:div, class: "#{brand}-tabs", 'data-module': "#{brand}-tabs") do
            safe_buffer = ActiveSupport::SafeBuffer.new

            safe_buffer.concat(content_tag(:h2, @tab.title, class: "#{brand}-tabs__title")) if @tab.title
            safe_buffer.concat(tabs_list_content) if @tab.tabs.present?
            safe_buffer.concat(tabs_body_content) if @tab.tabs.present?
            safe_buffer
          end
        end

        private

        def tabs_list_content
          content_tag(:ul, class: "#{brand}-tabs__list") do
            @tab.tabs.each_with_object(ActiveSupport::SafeBuffer.new) do |(name, _content, id, sel), link_buffer|
              style = if sel
                        "#{brand}-tabs__list-item #{brand}-tabs__list-item--selected"
                      else
                        "#{brand}-tabs__list-item"
                      end
              link_buffer.concat(
                content_tag(:li, class: style) do
                  content_tag(:a, name, class: "#{brand}-tabs__tab", href: "##{id}")
                end
              )
            end
          end
        end

        def tabs_body_content
          @tab.tabs.each_with_object(ActiveSupport::SafeBuffer.new) do |(_name, content, id, sel), body_buffer|
            style = if sel
                      "#{brand}-tabs__panel"
                    else
                      "#{brand}-tabs__panel #{brand}-tabs__panel--hidden"
                    end
            body_buffer.concat(content_tag(:div, content, class: style, id:))
          end
        end
      end
    end
  end
end
