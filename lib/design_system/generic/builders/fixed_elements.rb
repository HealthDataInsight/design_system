# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class is used to provide the generic fixed elements builder.
      class FixedElements < Base
        include Elements::Backlink
        include Elements::Breadcrumbs
        include Elements::Form
        include Elements::Headings
        include Elements::LeadParagraph

        def render
          raise ArgumentError, 'Cannot use both backlink and breadcrumbs' if @backlink && @breadcrumbs.present?

          content_for_breadcrumbs if @breadcrumbs.present?
          content_for_backlink if @backlink.present?

          render_main_container do
            safe_buffer = ActiveSupport::SafeBuffer.new

            safe_buffer.concat(render_main_heading) if @main_heading
            safe_buffer.concat(render_lead_paragraph) if @lead_paragraph
            safe_buffer.concat(render_form) if @form_object

            safe_buffer
          end
        end

        private

        def render_main_container(&)
          content_tag(:div, &)
        end
      end
    end
  end
end
