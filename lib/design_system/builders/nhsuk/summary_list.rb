# frozen_string_literal: true

require 'design_system/builders/generic/summary_list'

module DesignSystem
  module Builders
    module Nhsuk
      class SummaryList < ::DesignSystem::Builders::Generic::SummaryList
        private

        def validate_mix_actions
          if @summary_list.items.any? { |item| item[:actions].empty? } &&
             @summary_list.items.any? { |item| item[:actions].any? }
            raise ArgumentError, 'A mix of items with and without actions is not supported for NHS brand.'
          end
        end

        def render_items
          validate_mix_actions

          content_tag(:dl, class: 'nhsuk-summary-list') do
            @summary_list.items.each_with_object(ActiveSupport::SafeBuffer.new) do |item, items_buffer|
              items_buffer.concat(render_item(item))
            end
          end
        end

        def render_actions(item)
          content_tag(:dd, class: 'nhsuk-summary-list__actions') do
            if item[:actions].length == 1
              render_action(item[:actions].first)
            else
              content_tag(:ul, class: 'nhsuk-summary-list__actions-list') do
                item[:actions].each_with_object(ActiveSupport::SafeBuffer.new) do |action, actions_buffer|
                  actions_buffer.concat(content_tag(:li, render_action(action),
                                                    class: 'nhsuk-summary-list__actions-list-item'))
                end
              end
            end
          end
        end

        def render_action(action)
          content_tag(:a, href: action[:options][:path] || '#') do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(action[:content])

            if action[:options][:hidden_text]
              safe_buffer.concat(content_tag(:span, action[:options][:hidden_text], class: 'nhsuk-u-visually-hidden'))
            end

            safe_buffer
          end
        end
      end
    end
  end
end
