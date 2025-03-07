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
            safe_buffer.concat(DesignSystem::Registry.builder(brand, 'heading', self).render_heading(@main_heading, level: 1))
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
