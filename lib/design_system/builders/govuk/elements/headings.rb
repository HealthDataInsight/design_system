module DesignSystem
  module Builders
    module Govuk
      module Elements
        # This mixin module is used to provide GOV.UK page headings.
        module Headings
          private

          # GOVUK renders caption before main heading.
          # Keep the caption brief, preferably a single word or a short phrase
          def render_caption
            content_tag(:span, @caption, class: "#{brand}-caption-m")
          end
        end
      end
    end
  end
end
