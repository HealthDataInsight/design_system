# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      class SummaryList < ::DesignSystem::Generic::Builders::SummaryList
        private

        def render_hidden_text(hidden_text)
          return '' if hidden_text.blank?

          content_tag(:span, hidden_text, class: "#{brand}-u-visually-hidden")
        end
      end
    end
  end
end
