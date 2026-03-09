# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic summary list.
      class SummaryList < Base
        include ActionView::Helpers::OutputSafetyHelper

        def render_summary_list
          @summary_list = ::DesignSystem::Components::SummaryList.new
          yield @summary_list

          safe_buffer = ActiveSupport::SafeBuffer.new
          safe_buffer.concat(render_rows)

          safe_buffer
        end

        private

        def render_rows
          content_tag(:dl, class: "#{brand}-summary-list") do
            @summary_list.rows.map { |row| render_row(row) }.join.html_safe
          end
        end

        def render_row(row)
          content_tag(:div, class: "#{brand}-summary-list__row") do
            [render_key(row),
             render_value(row),
             render_actions(row)].compact.join.html_safe
          end
        end

        def render_key(row)
          content_tag(:dt, row[:key][:content], class: "#{brand}-summary-list__key")
        end

        def render_value(row)
          content_tag(:dd, class: "#{brand}-summary-list__value") do
            if row[:values].blank?
              ''
            elsif row[:values].length == 1
              row[:values].first[:content]
            else
              row[:values].map { |value| content_tag(:p, value[:content], class: "#{brand}-body") }.join.html_safe
            end
          end
        end

        def render_actions(row)
          content_tag(:dd, class: "#{brand}-summary-list__actions") do
            if row[:actions].blank?
              ''
            elsif row[:actions].length == 1
              render_action(row[:actions].first)
            else
              content_tag(:ul, class: "#{brand}-summary-list__actions-list") do
                row[:actions].map do |action|
                  content_tag(:li, render_action(action), class: "#{brand}-summary-list__actions-list-item")
                end.join.html_safe
              end
            end
          end
        end

        def render_action(action)
          options = action[:options].dup
          path = options.delete(:path) || '#'
          hidden_text = options.delete(:hidden_text)

          link_to(path, { class: "#{brand}-link" }.merge(options)) do
            safe_join([action[:content], render_hidden_text(hidden_text)])
          end
        end

        def render_hidden_text(hidden_text)
          return '' if hidden_text.blank?

          content_tag(:span, hidden_text, class: "#{brand}-visually-hidden")
        end
      end
    end
  end
end
