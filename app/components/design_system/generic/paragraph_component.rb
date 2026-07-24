module DesignSystem
  module Generic
    # Body paragraph with typography styling, rendered by ds_paragraph.
    # Content can be passed as the `text` argument or as a block. An optional
    # `size` selects a smaller body style.
    class ParagraphComponent < DesignSystem::BaseComponent
      FONT_SIZES = %i[s].freeze

      def initialize(text: nil, size: nil, **options)
        super()
        @text = text
        @size = size
        @options = options
      end

      attr_reader :text, :size, :options

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

      def paragraph_options
        { class: classes }.merge(options)
      end

      private

      def classes
        return "#{brand}-body" if size.nil?
        raise ArgumentError, "Invalid size: #{size}" unless size.in?(FONT_SIZES)

        "#{brand}-body-#{size}"
      end
    end
  end
end
