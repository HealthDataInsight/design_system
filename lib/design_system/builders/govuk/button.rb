# frozen_string_literal: true

require 'design_system/builders/generic/button'

module DesignSystem
  module Builders
    module Govuk
      # This class provides GOVUK Button.
      class Button < ::DesignSystem::Builders::Generic::Button
        def render_button(text, style, options)
          safe_buffer = ActiveSupport::SafeBuffer.new
          @classes = case style
                     when 'primary'
                       "#{brand}-button"
                     when 'secondary'
                       "#{brand}-button #{brand}-button--secondary"
                     when 'warning'
                       "#{brand}-button #{brand}-button--warning"
                     when 'reverse' # dark bg
                       "#{brand}-button #{brand}-button--inverse"
                     end
          href_path = options[:href]
          merged_options = options.except(:href).merge('data-module': "#{brand}-button")
          safe_buffer.concat(content_tag_button(text, href_path, merged_options))
          safe_buffer
        end

        def render_start_button(text, href, options)
          safe_buffer = ActiveSupport::SafeBuffer.new
          safe_buffer.concat(render_start_tag(text, href, options))
          safe_buffer
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

        def content_tag_button(text, href_path, merged_options)
          if href_path
            content_tag(:a, text,
                        { href: href_path, class: @classes, role: 'button', **merged_options })
          else
            content_tag(:button, text, type: 'submit', class: @classes, **merged_options)
          end
        end
      end
    end
  end
end
