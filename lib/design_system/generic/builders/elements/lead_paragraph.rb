# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      module Elements
        # This mixin module is used to provide lead paragraphs.
        module LeadParagraph
          def lead_paragraph(text = nil, &block)
            raise ArgumentError, 'Lead paragraph can only be used once per page' if @lead_paragraph

            @lead_paragraph = block_given? ? capture(&block) : text
          end

          private

          def render_lead_paragraph
            # Lead paragraph is a large body paragraph that should be used at the page top and once per page.
            return unless @lead_paragraph

            content_tag('p', @lead_paragraph, class: "#{brand}-body-l")
          end
        end
      end
    end
  end
end
