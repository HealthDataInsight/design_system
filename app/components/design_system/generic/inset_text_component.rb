module DesignSystem
  module Generic
    # Inset text used to differentiate a block of content from what surrounds
    # it, rendered by ds_inset_text. Content comes from the `text` argument or
    # a block (block wins if both are given). Renders nothing when blank.
    class InsetTextComponent < DesignSystem::BaseComponent
      def initialize(text: nil, **options)
        super()
        @text = text
        @options = options
      end

      attr_reader :text, :options

      def render?
        text.present? || content.present?
      end

      def inset_options
        css_class_options_merge(options, ["#{brand}-inset-text"])
      end
    end
  end
end
