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

        if content.present?
          button_tag(nil) { content }
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

        { 'name' => 'button', 'type' => 'submit',
          'data-module' => "#{brand}-button" }.merge!(options.stringify_keys)
      end
    end
  end
end
