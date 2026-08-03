# frozen_string_literal: true

module DesignSystem
  module Components
    # Collects the fixed page elements declared inside a `ds_fixed_elements`
    # block (backlink, breadcrumbs, main heading, lead paragraph and form).
    # The per-brand FixedElementsComponent turns this into markup.
    class FixedElements
      attr_reader :backlink_config, :breadcrumbs, :main_heading_config, :lead_paragraph_content, :form_object

      def initialize(view_context = nil)
        @view_context = view_context
        @breadcrumbs = []
      end

      def backlink(label, path)
        @backlink_config = { label: label || 'Back', path: }
      end

      def breadcrumb(label, path)
        @breadcrumbs << { label:, path: }
      end

      def main_heading(text, caption: nil)
        @main_heading_config = { text:, caption: }
      end

      def lead_paragraph(text = nil, &block)
        raise ArgumentError, 'Lead paragraph can only be used once per page' if @lead_paragraph_content

        @lead_paragraph_content = block ? @view_context.capture(&block) : text
      end

      def form(object)
        @form_object = object
      end

      def backlink?
        !@backlink_config.nil?
      end

      def breadcrumbs?
        @breadcrumbs.any?
      end
    end
  end
end
