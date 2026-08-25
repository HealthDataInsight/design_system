# frozen_string_literal: true

module DesignSystem
  module Components
    # Collects the fixed page elements declared inside a `ds_fixed_elements`
    # block (backlink, breadcrumbs, main heading, lead paragraph and form).
    # The per-brand FixedElementsComponent turns this into markup.
    #
    # Also returned when `ds_fixed_elements` is called without a block, so
    # callers can configure the collector and call `render` themselves.
    class FixedElements
      attr_reader :backlink_config, :breadcrumbs, :main_heading_config, :lead_paragraph_content, :form_object

      # A view context is required: lead_paragraph captures block content
      # through it, and `render` uses it for content_for / component output.
      def initialize(view_context)
        @view_context = view_context
        @breadcrumbs = []
      end

      def brand
        @view_context.brand
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

      def render
        raise ArgumentError, 'Cannot use both backlink and breadcrumbs' if backlink? && breadcrumbs?

        assign_slots
        @view_context.render DesignSystem::Registry.component(brand, :fixed_elements).new(fixed_elements: self)
      end

      private

      # Backlink and breadcrumbs are placed in their own page slots via
      # content_for, which must run on the view (not inside the component, whose
      # content_for writes to a separate output flow).
      def assign_slots
        if breadcrumbs?
          @view_context.content_for(:breadcrumbs) do
            @view_context.render DesignSystem::Registry.component(brand, :breadcrumbs).new(breadcrumbs:)
          end
        end

        return unless backlink?

        config = backlink_config
        @view_context.content_for(:backlink) do
          @view_context.link_to(config[:label], config[:path], class: "#{brand}-back-link")
        end
      end
    end
  end
end
