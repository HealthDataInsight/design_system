module DesignSystem
  module Generic
    # Inset text used to differentiate a block of content from what surrounds
    # it, rendered by ds_inset_text. Content can be passed as the `text`
    # argument or as a block. The NHS brand renders a visually hidden
    # "Information:" prefix via its own subclass and template.
    class InsetTextComponent < DesignSystem::BaseComponent
      def initialize(text: nil, **options)
        super()
        @text = text
        @options = options
      end

      attr_reader :text, :options

      # Renders nothing when neither block content nor text is supplied,
      # matching the previous builder behaviour.
      def render?
        body.present?
      end

      # The content to display: a captured block takes precedence over the
      # text argument.
      def body
        content.presence || text
      end

      def inset_options
        css_class_options_merge(options, ["#{brand}-inset-text"])
      end
    end
  end
end
