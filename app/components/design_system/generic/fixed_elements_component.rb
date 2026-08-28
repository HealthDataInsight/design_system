module DesignSystem
  module Generic
    # Renders the main container of the fixed page elements declared via
    # `ds_fixed_elements`: the main heading, lead paragraph and form. The
    # backlink and breadcrumbs are placed in their own page slots by the
    # helper. Brand subclasses override only the caption markup.
    class FixedElementsComponent < DesignSystem::BaseComponent
      def initialize(fixed_elements:)
        super()
        @fixed_elements = fixed_elements
      end

      attr_reader :fixed_elements

      def call
        content_tag(:div) do
          safe_buffer = ActiveSupport::SafeBuffer.new

          safe_buffer.concat(render_main_heading) if fixed_elements.main_heading_config
          safe_buffer.concat(render_lead_paragraph) if fixed_elements.lead_paragraph_content
          safe_buffer.concat(render_form) if fixed_elements.form_object

          safe_buffer
        end
      end

      private

      def render_main_heading
        config = fixed_elements.main_heading_config
        safe_buffer = ActiveSupport::SafeBuffer.new

        safe_buffer.concat(render_caption(config[:caption])) if config[:caption]
        safe_buffer.concat(render(DesignSystem::Registry.component(brand, :heading).new(config[:text], level: 1)))

        safe_buffer
      end

      def render_caption(caption)
        content_tag(:span, caption)
      end

      def render_lead_paragraph
        # Lead paragraph is a large body paragraph used at the page top, once per page.
        content_tag('p', fixed_elements.lead_paragraph_content, class: "#{brand}-body-l")
      end

      def render_form
        name = fixed_elements.form_object.class.name.underscore
        helpers.render('form', name.to_sym => fixed_elements.form_object)
      end
    end
  end
end
