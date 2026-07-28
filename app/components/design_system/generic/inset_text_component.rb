module DesignSystem
  module Generic
    # Inset text used to differentiate a block of content from what surrounds
    # it, rendered by ds_inset_text. Content must be passed as either the
    # `text` argument or a block.
    class InsetTextComponent < DesignSystem::BaseComponent
      def initialize(text: nil, **options)
        super()
        @text = text
        @options = options
      end

      attr_reader :text, :options

      def before_render
        raise ArgumentError, 'provide either text or a block' unless text.present? ^ content.present?
      end

      def inset_options
        css_class_options_merge(options, ["#{brand}-inset-text"])
      end
    end
  end
end
