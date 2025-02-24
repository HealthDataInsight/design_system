# frozen_string_literal: true

require 'design_system/builders/generic/summary_list'

module DesignSystem
  module Builders
    module Govuk
      class SummaryList < ::DesignSystem::Builders::Generic::SummaryList
        private

        def render_item(item)
          item_classes = ['govuk-summary-list__row']
          item_classes << 'govuk-summary-list__row--no-actions' if item[:actions].empty?

          content_tag(:div, class: item_classes.join(' ')) do
            item_buffer = ActiveSupport::SafeBuffer.new

            item_buffer.concat(render_data(item))
            item_buffer.concat(render_actions(item)) if item[:actions].any?

            item_buffer
          end
        end

        def render_actions(item)
          content_tag(:dd, class: 'govuk-summary-list__actions') do
            if item[:actions].length == 1
              render_action(item[:actions].first)
            else
              content_tag(:ul, class: 'govuk-summary-list__actions-list') do
                item[:actions].each_with_object(ActiveSupport::SafeBuffer.new) do |action, actions_buffer|
                  actions_buffer.concat(content_tag(:li, render_action(action),
                                                    class: 'govuk-summary-list__actions-list-item'))
                end
              end
            end
          end
        end

        def render_action(action)
          content_tag(:a, class: 'govuk-link', href: action[:options][:path] || '#') do
            safe_buffer = ActiveSupport::SafeBuffer.new
            safe_buffer.concat(action[:content])

            if action[:options][:hidden_text]
              safe_buffer.concat(content_tag(:span, action[:options][:hidden_text], class: 'govuk-visually-hidden'))
            end

            safe_buffer
          end
        end
      end
    end
  end
end
