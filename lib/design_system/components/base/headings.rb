module DesignSystem
  module Components
    module Base
      # This mixin module is used to provide page headings.
      module Headings
        def main_heading(text)
          @main_heading = text
        end

        private

        def render_main_heading
          content_tag(:h1, @main_heading)
        end
      end
    end
  end
end
