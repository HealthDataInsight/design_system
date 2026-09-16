module DesignSystem
  module Govuk
    # GOV.UK fixed elements: renders the caption with its own modifier class.
    class FixedElementsComponent < DesignSystem::Generic::FixedElementsComponent
      private

      # GOV.UK renders the caption before the main heading with its own
      # modifier class. Keep the caption brief, preferably a single word or a
      # short phrase.
      def render_caption(caption)
        content_tag(:span, caption, class: "#{brand}-caption-m")
      end
    end
  end
end
