# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      # This generates html for rendering inset text for Nhsuk
      class InsetText < ::DesignSystem::Generic::Builders::InsetText
        def render_inset_text(text = nil, **options, &)
          content = block_given? ? capture(&) : text
          return if content.blank?

          wrapped_content = block_given? ? content : content_tag(:p, content)

          div_options = css_class_options_merge(options, ["#{brand}-inset-text"])

          content_tag(:div, **div_options) do
            content_tag(:span, 'Information: ', class: "#{brand}-u-visually-hidden") + wrapped_content
          end
        end
      end
    end
  end
end
