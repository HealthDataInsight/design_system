module DesignSystem
  module Generic
    # Base tab component. Brands implement the markup; the generic component
    # is abstract.
    class TabComponent < DesignSystem::BaseComponent
      def initialize(tab:)
        super()
        @tab = tab
      end

      attr_reader :tab

      def call
        raise 'Subclass needs to implement brand specific rendering'
      end
    end
  end
end
