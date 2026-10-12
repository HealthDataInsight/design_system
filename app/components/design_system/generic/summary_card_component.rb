module DesignSystem
  module Generic
    # Card that groups a titled summary list (or any content) with optional
    # actions, rendered by ds_summary_card. The GOV.UK brand renders a
    # summary-card variant via its own subclass and template.
    #
    # Each action is a hash of { text:, href:, hidden_text: }, where
    # hidden_text is appended in a visually hidden span to give the link an
    # accessible, unambiguous name (e.g. " (Karen Francis)").
    class SummaryCardComponent < DesignSystem::BaseComponent
      include DesignSystemHelper

      def initialize(title:, actions: [], heading: {})
        super()
        @title = title
        @actions = Array(actions)
        @heading_options = Hash.try_convert(heading) || {}
      end

      attr_reader :title, :actions

      def render_action(action)
        link_to(action[:href] || '#', class: "#{brand}-link") do
          safe_join([action[:text], render_hidden_text(action[:hidden_text])])
        end
      end

      private

      def default_heading_level = 2

      def heading_level
        @heading_options.symbolize_keys.fetch(:level, default_heading_level)
      end

      def render_hidden_text(hidden_text)
        return '' if hidden_text.blank?

        content_tag(:span, hidden_text, class: visually_hidden_class)
      end

      def visually_hidden_class
        "#{brand}-u-visually-hidden"
      end
    end
  end
end
