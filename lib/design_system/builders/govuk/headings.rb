module DesignSystem
  module Builders
    module Govuk
      # This mixin module is used to provide GOV.UK page headings.
      module Headings
        private

        def render_main_heading
          content_tag(:h1, @main_heading, class: "#{brand}-heading-xl")
        end
      end
    end
  end
end
