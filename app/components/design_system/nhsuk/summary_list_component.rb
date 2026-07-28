module DesignSystem
  module Nhsuk
    # NHS summary list: hidden action text uses the nhsuk-u-visually-hidden
    # utility class.
    class SummaryListComponent < DesignSystem::Generic::SummaryListComponent
      private

      def value_paragraph_class
        nil
      end

      def render_hidden_text(hidden_text)
        return '' if hidden_text.blank?

        content_tag(:span, hidden_text, class: "#{brand}-u-visually-hidden")
      end
    end
  end
end
