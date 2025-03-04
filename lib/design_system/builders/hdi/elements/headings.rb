module DesignSystem
  module Builders
    module Hdi
      module Elements
        # This mixin module is used to provide HDI page headings.
        module Headings
          private

          def render_main_heading
            content_tag(:h1, @main_heading, class: 'text-3xl font-bold tracking-tight sm:text-4xl text-gray-900 mb-4')
          end

          def render_subheading
            content_tag(:h2, @subheading, class: 'text-2xl font-semibold leading-6 text-gray-900 mb-4')
          end

          def render_caption
            content_tag(:span, @caption, class: 'text-sm hdi-text-500 mb-4')
          end
        end
      end
    end
  end
end
