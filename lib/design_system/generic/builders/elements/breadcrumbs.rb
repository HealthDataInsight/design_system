module DesignSystem
  module Generic
    module Builders
      module Elements
        # This mixin accumulates breadcrumbs and renders them into the
        # :breadcrumbs content_for slot via the per-brand BreadcrumbsComponent.
        module Breadcrumbs
          def breadcrumb(label, path)
            @breadcrumbs ||= []
            @breadcrumbs << { label:, path: }
          end

          private

          def content_for_breadcrumbs
            content_for(:breadcrumbs) do
              component = ::DesignSystem::Registry.component(brand, :breadcrumbs).new(breadcrumbs: @breadcrumbs)
              @context.render(component)
            end
          end
        end
      end
    end
  end
end
