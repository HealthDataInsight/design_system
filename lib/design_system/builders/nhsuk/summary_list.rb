# frozen_string_literal: true

require 'design_system/builders/generic/summary_list'

module DesignSystem
  module Builders
    module Nhsuk
      class SummaryList < ::DesignSystem::Builders::Generic::SummaryList
        private

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
