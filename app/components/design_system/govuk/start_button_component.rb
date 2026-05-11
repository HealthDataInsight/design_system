module DesignSystem
  module Govuk
    # Renders the "start a service" CTA defined by GOV.UK and adopted by NHS.
    # Lives in the Govuk namespace because both GOV.UK and NHS.UK ship the
    # same markup; the NHS subclass exists only so the brand-derived classes
    # come out as `nhsuk-…`.
    class StartButtonComponent < DesignSystem::BaseComponent
      def initialize(text, href, options = {})
        super()
        @text = text
        @href = href
        @options = options.merge('data-module': "#{brand}-button")
      end

      attr_reader :text, :href, :options
    end
  end
end
