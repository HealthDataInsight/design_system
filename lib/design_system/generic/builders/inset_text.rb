# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This generates html for rendering inset text to help users identify and understand important content on the page.
      class InsetText < Base
        def render_inset_text(text = nil, **options, &block)
          content = block_given? ? capture(&block) : text
          return if content.blank?

          content_tag(:div, content, class: "#{brand}-inset-text", **options)
        end
      end
    end
  end
end
