module DesignSystem
  module Components
    # This mixin module is used to provide breadcrumbs.
    module Breadcrumbs
      def breadcrumb(label, path)
        @breadcrumbs ||= []
        @breadcrumbs << { label: label, path: path }
      end

      private

      def content_for_breadcrumbs
        content_for(:breadcrumbs) do
          safe_buffer = ActiveSupport::SafeBuffer.new

          @breadcrumbs.each do |breadcrumb|
            safe_buffer.concat(render_breadcrumb(breadcrumb))
            safe_buffer.concat(' > ') unless @breadcrumbs.last == breadcrumb
          end

          safe_buffer
        end
      end

      def home_path?(path)
        root_hash = Rails.application.routes.recognize_path(@context.root_path)
        path_hash = Rails.application.routes.recognize_path(path)

        %i[controller action].each do |key|
          return false if root_hash[key] != path_hash[key]
        end

        true
      end

      def render_breadcrumb(breadcrumb)
        link_to_unless_current(breadcrumb[:label], breadcrumb[:path])
      end
    end
  end
end
