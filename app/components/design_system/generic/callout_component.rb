module DesignSystem
  module Generic
    # NHS-style warning callout: the GOV.UK brand renders a warning-text
    # variant via its own subclass and template.
    class CalloutComponent < DesignSystem::BaseComponent
      def initialize(label:, body:)
        super()
        @label = label
        @body = body
      end

      attr_reader :label, :body
    end
  end
end
