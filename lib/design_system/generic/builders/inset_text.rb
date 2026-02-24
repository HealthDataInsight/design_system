# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This generates html for rendering inset text to help users identify and understand important content on the page.
      class InsetText < Base
        def render_inset_text(text = nil, **options, &)
          content = block_given? ? capture(&) : text
          return if content.blank?

          div_options = css_class_options_merge(options, ["#{brand}-inset-text"])
          content_tag(:div, content, **div_options)
        end
      end
    end
  end
end
