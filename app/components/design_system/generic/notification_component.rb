module DesignSystem
  module Generic
    # Notification banner rendered by ds_notice. Shows an "Important"/"Success"
    # header followed by a content area with an optional heading and the
    # message (or block) body.
    class NotificationComponent < DesignSystem::BaseComponent
      TYPES = %i[information success].freeze
      HEADING_TAGS = %i[h3 p].freeze

      def initialize(message: nil, type: :information, content_heading: {})
        super()
        @message = message
        @type = type
        @content_heading = content_heading || {}

        return if TYPES.include?(type)

        raise ArgumentError, "Invalid notification type: #{type}. Must be one of: #{TYPES.join(', ')}"
      end

      attr_reader :message, :type, :content_heading

      def heading_tag
        tag = content_heading.fetch(:tag, :h3)
        raise ArgumentError, "Invalid content_heading tag: #{tag}." unless HEADING_TAGS.include?(tag)

        tag
      end

      def heading_text
        content_heading[:text]
      end

      def body
        content.presence || message
      end
    end
  end
end
