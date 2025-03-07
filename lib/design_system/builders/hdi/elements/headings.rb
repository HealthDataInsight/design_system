module DesignSystem
  module Builders
    module Hdi
      module Elements
        # This mixin module is used to provide HDI page headings.
        module Headings
          private

          def render_main_heading
            safe_buffer = ActiveSupport::SafeBuffer.new

            # HDI renders caption below the main heading.
            # Longer captions up to one or two sentences are accepted.
            safe_buffer.concat(content_tag(:h1, @main_heading,
                                           class: 'text-3xl font-bold tracking-tight sm:text-4xl text-gray-900 mb-2 break-words'))
            safe_buffer.concat(render_caption) if @caption

            safe_buffer
          end

          def render_caption
            content_tag(:span, @caption, class: 'text-xs sm:text-sm hdi-text-500 mt-2 mb-2 block')
          end
        end
      end
    end
  end
end
