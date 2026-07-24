module DesignSystem
  module Generic
    # Link (or button-styled link) rendered by ds_link_to. Mirrors the
    # polymorphic Rails link_to signature: with a block the first argument is
    # the URL, otherwise it is the link text. A :type option selects a
    # button style (defined per brand). The link_context switches the default
    # link class (e.g. inside a notification banner).
    class LinkComponent < DesignSystem::BaseComponent
      def initialize(name = nil, options = nil, html_options = nil, link_context: nil)
        super()
        @name = name
        @options = options || {}
        @html_options = html_options || {}
        @link_context = link_context
      end

      attr_reader :name, :options, :html_options

      def call
        if content.present?
          type = options.delete(:type)
          options[:class] = prep_link_classes(type)
          link_to(name, options, html_options) { content }
        else
          type = html_options.delete(:type)
          html_options[:class] = prep_link_classes(type)
          link_to(name, options, html_options)
        end
      end

      private

      def prep_link_classes(type)
        if type && button_type_class_hash[type].present?
          button_type_class_hash[type]
        else
          link_class
        end
      end

      def link_class
        case @link_context
        when :notification_banner
          "#{brand}-notification-banner__link"
        else
          "#{brand}-link"
        end
      end
    end
  end
end
