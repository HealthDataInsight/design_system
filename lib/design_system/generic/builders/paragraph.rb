# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display paragraphs with typography styles.
      class Paragraph < Base
        def render_paragraph(text = nil, size: nil, **options, &block)
          content = block_given? ? capture(&block) : text
          return if content.blank?

          content_tag('p', content, class: classes(size), **options)
        end

        private

        def classes(size)
          return "#{brand}-body" if size.nil?
          raise ArgumentError, "Invalid size: #{size}" unless size.in?(%w[s l])

          "#{brand}-body-#{size}"
        end
      end
    end
  end
end
