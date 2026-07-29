module DesignSystem
  module Generic
    # Tabs rendered by ds_tab: a list of tab links followed by their panels,
    # with the selected panel visible. Brand subclasses inherit unchanged.
    class TabComponent < DesignSystem::BaseComponent
      def initialize(tab:)
        super()
        @tab = tab
      end

      attr_reader :tab
    end
  end
end
