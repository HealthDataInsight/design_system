module DesignSystem
  module Builders
    module Generic
      module Elements
        # This mixin module is used to provide page headings.
        module Headings
          def main_heading(text, caption: nil)
            @main_heading = text
            @caption = caption
          end

          private

          def render_main_heading
            safe_buffer = ActiveSupport::SafeBuffer.new

            safe_buffer.concat(render_caption) if @caption
            safe_buffer.concat(DesignSystem::Registry.builder(brand, 'heading', self).render_heading(@main_heading, level: 1))


            safe_buffer
          end

          def render_caption
            content_tag(:span, @caption)
          end
        end
      end
    end
  end
end
