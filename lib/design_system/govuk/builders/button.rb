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

        def render_start_button(text, href, options)
          render_start_tag(text, href, options)
        end

        private

        def render_start_tag(text, href, options)
          merged_options = options.merge('data-module': "#{brand}-button")
          buffer = ActiveSupport::SafeBuffer.new
          content_tag(:a, href:, class: "#{brand}-button #{brand}-button--start",
                          role: 'button', draggable: 'false', **merged_options) do
            buffer.concat(content_tag(:span, text, class: "#{brand}-button-text"))
            buffer.concat(
              content_tag(:svg, '', class: "#{brand}-button__start-icon", xmlns: 'http://www.w3.org/2000/svg',
                                    width: '17.5', height: '19', viewBox: '0 0 33 40', aria: { hidden: 'true' },
                                    focusable: 'false') do
                                      content_tag(:path, '', fill: 'currentColor', d: 'M0 0h13l20 20-20 20H0l20-20z')
                                    end
            )
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
