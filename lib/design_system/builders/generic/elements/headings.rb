module DesignSystem
  module Builders
    module Generic
      module Elements
        # This mixin module is used to provide page headings.
        module Headings
          def main_heading(text)
            @main_heading = text
          end

          def subheading(text)
            @subheading = text
          end

          def caption(text)
            @caption = text
          end

          private

          def render_main_heading
            content_tag(:h1, @main_heading)
          end

          def render_subheading
            content_tag(:h2, @subheading)
          end

          def render_caption
            content_tag(:span, @caption)
          end
        end
      end
    end
  end
end
