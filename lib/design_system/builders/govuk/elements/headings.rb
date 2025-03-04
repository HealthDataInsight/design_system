module DesignSystem
  module Builders
    module Govuk
      module Elements
        # This mixin module is used to provide GOV.UK page headings.
        module Headings
          private

          def render_main_heading
            content_tag(:h1, @main_heading, class: "#{brand}-heading-xl")
          end

          def render_subheading
            content_tag(:h2, @subheading, class: "#{brand}-heading-l")
          end

          def render_caption
            content_tag(:span, @caption, class: "#{brand}-caption-m")
          end
        end
      end
    end
  end
end
