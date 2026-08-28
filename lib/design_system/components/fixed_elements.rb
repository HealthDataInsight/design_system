# frozen_string_literal: true

module DesignSystem
  module Components
    # Collects the fixed page elements declared via `ds_fixed_elements`
    # (backlink, breadcrumbs, main heading, lead paragraph and form).
    # Returned when the helper is called without a block so callers can
    # configure it and call `render` themselves; with a block the helper
    # yields this collector then calls `render`.
    #
    # The per-brand FixedElementsComponent turns the collected data into
    # markup. Backlink/breadcrumbs use content_for on the view context
    # (not inside the component, whose content_for uses a separate flow).
    class FixedElements
      attr_reader :backlink, :breadcrumbs, :main_heading_config, :lead_paragraph_content, :form_object

      delegate :brand, to: :@view_context

      def initialize(view_context)
        @view_context = view_context
        @breadcrumbs = []
      end

      def backlink(label, path)
        @backlink = { label: label || 'Back', path: }
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

      def render
        raise ArgumentError, 'Cannot use both backlink and breadcrumbs' if @backlink.present? && @breadcrumbs.present?

        assign_slots
        render_component(:fixed_elements, fixed_elements: self)
      end

      private

      def assign_slots
        @view_context.content_for(:breadcrumbs) { render_component(:breadcrumbs, breadcrumbs:) } if @breadcrumbs.any?

        return unless @backlink.present?

        @view_context.content_for(:backlink) do
          @view_context.link_to(@backlink[:label], @backlink[:path], class: "#{brand}-back-link")
        end
      end

      def render_component(name, **kwargs)
        @view_context.render DesignSystem::Registry.component(brand, name).new(**kwargs)
      end
    end
  end
end
