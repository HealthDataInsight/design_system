module DesignSystem
  module Generic
    # Error-summary alert rendered by ds_alert. Content comes from the message
    # argument or a block.
    class AlertComponent < DesignSystem::BaseComponent
      def initialize(message = nil)
        super()
        @message = message
      end

      def call
        content_tag(:div, class: "#{brand}-error-summary", 'aria-labelledby': 'error-summary-title',
                          role: 'alert', tabindex: '-1') do
          content_tag(:h2, body, class: "#{brand}-error-summary__title", id: 'error-summary-title')
        end
      end

      private

      def body
        content.presence || @message
      end
    end
  end
end
