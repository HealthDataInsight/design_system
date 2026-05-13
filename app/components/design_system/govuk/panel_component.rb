module DesignSystem
  module Govuk
    # GOV.UK confirmation panel.
    class PanelComponent < DesignSystem::Generic::PanelComponent
      def panel_classes
        super + ["#{brand}-panel--confirmation"]
      end
    end
  end
end
