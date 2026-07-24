module DesignSystem
  module Generic
    # Notification banner rendered by ds_notice. Shows an "Important"/"Success"
    # header followed by a content area with an optional heading and the
    # message (or block) body.
    class NoticeComponent < DesignSystem::BaseComponent
      def initialize(message: nil, type: :information, content_heading: { text: nil, tag: :h3 })
        super()
        @message = message
        @type = type
        @content_heading = content_heading || {}

        return if notification_type_hash.key?(type)

        raise ArgumentError,
              "Invalid notification type: #{type}. Must be one of: #{notification_type_hash.keys.join(', ')}"
      end

      def call
        content_tag(:div, class: notification_type_hash.dig(@type, :class),
                          role: notification_type_hash.dig(@type, :role),
                          'aria-labelledby': "#{brand}-notification-banner-title",
                          'data-module': "#{brand}-notification-banner") do
          banner_title + banner_content
        end
      end

      private

      def banner_title
        content_tag(:div, class: "#{brand}-notification-banner__header") do
          content_tag(:h2, notification_type_hash.dig(@type, :header),
                      class: "#{brand}-notification-banner__title",
                      id: "#{brand}-notification-banner-title")
        end
      end

      def banner_content
        content_tag(:div, class: "#{brand}-notification-banner__content") do
          heading_markup = heading
          parts = []
          parts << heading_markup if heading_markup.present?
          parts << body if body.present?

          safe_join(parts)
        end
      end

      def heading
        return unless @content_heading.present? && @content_heading[:text].present?

        tag = @content_heading[:tag] || :h3
        raise ArgumentError, "Invalid content_heading tag: #{tag}.}" unless tag.in?(%i[h3 p])

        content_tag(tag, @content_heading[:text], class: "#{brand}-notification-banner__heading")
      end

      def body
        content.presence || @message
      end

      def notification_type_hash
        {
          information: {
            header: 'Important',
            class: "#{brand}-notification-banner",
            role: 'region'
          },
          success: {
            header: 'Success',
            class: "#{brand}-notification-banner #{brand}-notification-banner--success",
            role: 'alert'
          }
        }
      end
    end
  end
end
