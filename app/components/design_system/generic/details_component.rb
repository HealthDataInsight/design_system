module DesignSystem
  module Generic
    # Disclosure widget rendered by ds_details.
    class DetailsComponent < DesignSystem::BaseComponent
      def initialize(summary_text)
        super()
        @summary_text = summary_text
      end

      attr_reader :summary_text
    end
  end
end
