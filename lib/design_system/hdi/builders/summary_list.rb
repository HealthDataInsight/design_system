# frozen_string_literal: true

module DesignSystem
  module Hdi
    module Builders
      class SummaryList < ::DesignSystem::Generic::Builders::SummaryList
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
      end
    end
  end
end
