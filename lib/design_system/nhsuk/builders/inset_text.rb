# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      # This generates html for rendering inset text for Nhsuk
      class InsetText < ::DesignSystem::Generic::Builders::InsetText
        def render_inset_text(text = nil, **options, &block)
          content = block_given? ? capture(&block) : text
          return if content.blank?

          wrapped_content = block_given? ? content : content_tag(:p, content)

          div_options = css_class_options_merge(options, ["#{brand}-inset-text"])
          safe_buffer = ActiveSupport::SafeBuffer.new
          content_tag(:div, **div_options) do
            safe_buffer.concat(content_tag(:span, 'Information: ', class: "#{brand}-u-visually-hidden"))
            safe_buffer.concat(wrapped_content)
          end
        end
      end
    end
  end
end
