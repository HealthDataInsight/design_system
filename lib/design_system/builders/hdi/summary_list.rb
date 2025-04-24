# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      class SummaryList < ::DesignSystem::Builders::Generic::SummaryList
        private

        def render_actions(row)
          return if row[:actions].nil? || row[:actions].empty?

          content_tag(:dd, class: "#{brand}-summary-list__actions") do
            content_tag(:ul, class: "#{brand}-summary-list__actions-list") do
              row[:actions].map.with_index do |action, index|
                content_tag(:li,
                            render_action(action),
                            class: "#{brand}-summary-list__actions-list-item")
              end.join.html_safe
            end
          end
        end

        def render_action(action)
          link_to(action[:content],
                  action[:options][:path] || '#',
                  class: "#{brand}-link")
        end
      end
    end
  end
end
