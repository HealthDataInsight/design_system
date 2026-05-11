# frozen_string_literal: true

module DesignSystem
  module Govuk
    module Builders
      # This class provides GOVUK Button.
      class Button < ::DesignSystem::Generic::Builders::Button
        def render_button(content_or_options = nil, options = nil, &)
          options = prep_button_options(content_or_options, options)
          options[:class] = "#{brand}-button"

          options = css_class_options_merge(options) do |button_classes|
            button_classes << style_class_hash[options['style']]
          end

          if block_given?
            button_tag(options = nil, &)
          else
            button_tag(content_or_options, options)
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
end
