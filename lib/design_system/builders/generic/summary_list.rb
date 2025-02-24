# frozen_string_literal: true

require 'design_system/components/summary_list'
require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      class SummaryList < Base
        def render_summary_list
          @summary_list = ::DesignSystem::Components::SummaryList.new
          yield @summary_list

          safe_buffer = ActiveSupport::SafeBuffer.new
          safe_buffer.concat(render_items)

          safe_buffer
        end

        private

        def render_items
          content_tag(:dl, class: "#{brand}-summary-list") do
            @summary_list.items.each_with_object(ActiveSupport::SafeBuffer.new) do |item, items_buffer|
              items_buffer.concat(render_item(item))
            end
          end
        end

        def render_item(item)
          content_tag(:div, class: "#{brand}-summary-list__row") do
            item_buffer = ActiveSupport::SafeBuffer.new

            item_buffer.concat(render_data(item))
            item_buffer.concat(render_actions(item)) if item[:actions].any?

            item_buffer
          end
        end

        def render_data(item)
          content_tag(:dt, item[:key][:content], class: "#{brand}-summary-list__key")
          content_tag(:dd, item[:value][:content], class: "#{brand}-summary-list__value")
        end

        def render_actions(item)
          content_tag(:dd, class: "#{brand}-summary-list__actions") do
            if item[:actions].length == 1
              render_action(item[:actions].first)
            else
              content_tag(:ul, class: "#{brand}-summary-list__actions-list") do
                item[:actions].each_with_object(ActiveSupport::SafeBuffer.new) do |action, actions_buffer|
                  actions_buffer.concat(content_tag(:li, render_action(action),
                                                    class: "#{brand}-summary-list__actions-list-item"))
                end
              end
            end
          end
        end

        def render_action(action)
          content_tag(:a, action[:content], href: action[:options][:path] || '#')
        end
      end
    end
  end
end
