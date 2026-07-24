module DesignSystem
  module Govuk
    # GOV.UK button: adds the govuk-button class and optional style modifier.
    class ButtonComponent < DesignSystem::Generic::ButtonComponent
      def call
        button_options = prep_button_options(content_or_options, options)
        button_options[:class] = "#{brand}-button"

        button_options = css_class_options_merge(button_options) do |button_classes|
          button_classes << style_class_hash[button_options['style']]
        end

        if content.present?
          button_tag(nil) { content }
        else
          button_tag(content_or_options, button_options)
        end
      end

      private

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
