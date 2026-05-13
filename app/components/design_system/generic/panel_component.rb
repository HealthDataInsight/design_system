module DesignSystem
  module Generic
    # Confirmation/transaction panel rendered by ds_panel.
    class PanelComponent < DesignSystem::BaseComponent
      def initialize(title:, body:)
        super()
        @title = title
        @body = body
      end

      attr_reader :title, :body

      def panel_classes
        ["#{brand}-panel"]
      end
    end
  end
end
