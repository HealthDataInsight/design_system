# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides methods to render HDI button.
      class Button < ::DesignSystem::Builders::Generic::Button
        def render_button(content_or_options = nil, options = nil, &)
          options = prep_button_options(content_or_options, options)
          options[:class] = "#{brand}-button"

          options = css_class_options_merge(options) do |button_classes|
            button_classes << style_class_hash[options['style']]
          end

          options = add_disabled_class(options) if options[:disabled]

          if block_given?
            button_tag(options = nil, &)
          else
            button_tag(content_or_options, options)
          end
        end

        def render_start_button(_text, _href, _options)
          nil
        end

        private

        def add_disabled_class(options)
          css_class_options_merge(options) do |button_classes|
            button_classes << "#{brand}-button--disabled"
          end
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
end
