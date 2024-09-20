module DesignSystem
  module Builders
    module Hdi
      module Elements
        # This mixin module is used to provide HDI page headings.
        module Headings
          private

          def render_main_heading
            content_tag(:h1, @main_heading, class: 'text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl')
          end
        end
      end
    end
  end
end
