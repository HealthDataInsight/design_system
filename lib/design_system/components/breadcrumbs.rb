module DesignSystem
  module Components
    # This mixin module is used to provide breadcrumbs.
    module Breadcrumbs
      def breadcrumb(label, path)
        @breadcrumbs ||= []
        @breadcrumbs << { label:, path: }
      end

      private

      def render_breadcrumbs
        safe_buffer = ActiveSupport::SafeBuffer.new

        @breadcrumbs.each do |breadcrumb|
          safe_buffer.concat(render_breadcrumb(breadcrumb))
          safe_buffer.concat(' > ') unless @breadcrumbs.last == breadcrumb
        end

        safe_buffer
      end

      def render_breadcrumb(breadcrumb)
        link_to_unless_current(breadcrumb[:label], breadcrumb[:path])
      end
    end
  end
end
