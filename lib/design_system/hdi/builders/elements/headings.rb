module DesignSystem
  module Hdi
    module Builders
      module Elements
        # This mixin module is used to provide HDI page headings.
        module Headings
          private

          def render_caption
            content_tag(:span, @caption, class: "#{brand}-caption-m")
          end
        end
      end
    end
  end
end
