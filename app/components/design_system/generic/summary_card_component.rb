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
      def initialize(title:, actions: [], heading_level: 2)
        super()
        @title = title
        @actions = Array(actions)
        @heading_level = heading_level.to_i
      end

      attr_reader :title, :actions, :heading_level

      # Reuses the shared heading component (as ds_heading does) so the card
      # title stays consistent with the rest of the library.
      def heading_component
        DesignSystem::Registry.component(brand, :heading).new(title, level: heading_level, class: title_class)
      end

      def render_action(action)
        link_to(action[:href] || '#', class: "#{brand}-link") do
          safe_join([action[:text], render_hidden_text(action[:hidden_text])])
        end
      end

      private

      def title_class
        "#{brand}-card__heading #{brand}-heading-m"
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
