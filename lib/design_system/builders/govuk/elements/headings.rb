module DesignSystem
  module Builders
    module Govuk
      module Elements
        # This mixin module is used to provide GOV.UK page headings.
        module Headings
          private

          def render_main_heading
            safe_buffer = ActiveSupport::SafeBuffer.new

            # GOVUK renders caption before main heading.
            # Keep the caption brief, preferably a single word or a short phrase
            safe_buffer.concat(render_caption) if @caption
            safe_buffer.concat(content_tag(:h1, @main_heading, class: "#{brand}-heading-xl"))

            safe_buffer
          end

          def render_caption
            content_tag(:span, @caption, class: "#{brand}-caption-m")
          end
        end
      end
    end
  end
end
