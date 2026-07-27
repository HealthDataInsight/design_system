module DesignSystem
  module Generic
    # Submit button rendered by ds_button_tag. Brand subclasses add their
    # button classes and style modifiers. Content can be supplied via the
    # first argument or a block.
    class ButtonComponent < DesignSystem::BaseComponent
      def initialize(content_or_options = nil, options = nil)
        super()
        @content_or_options = content_or_options
        @options = options
      end

      attr_reader :content_or_options, :options

      def call
        button_options = prep_button_options(content_or_options, options)
        style = button_options.delete('style')
        button_options['aria-disabled'] = true if button_options['disabled']

        button_options = css_class_options_merge(button_options, ["#{brand}-button"]) do |classes|
          style_class = style_class_hash[style]
          classes << style_class if style_class
        end

        if content.present?
          button_tag(button_options) { content }
        else
          button_tag(content_or_options, button_options)
        end
      end

      private

      def prep_button_options(content_or_options, options)
        if content_or_options.is_a?(Hash)
          options = content_or_options
        else
          options ||= {}
        end

        { 'data-module' => "#{brand}-button" }.merge!(options.stringify_keys)
      end

      def style_class_hash
        {
          'secondary' => "#{brand}-button--secondary",
          'warning' => "#{brand}-button--warning",
          'reverse' => "#{brand}-button--inverse"
        }
      end
    end
  end
end
