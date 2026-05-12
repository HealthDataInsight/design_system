module DesignSystem
  module Generic
    # The "start a service" CTA. GOV.UK defined the pattern and NHS adopted it
    # unchanged — both brands ship identical markup with only the brand-derived
    # CSS prefix differing, so the implementation lives here.
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
