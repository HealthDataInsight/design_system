module DesignSystem
  module Generic
    # Breadcrumb trail rendered into the :breadcrumbs content_for slot by the
    # fixed-elements builder. Brands override the markup via subclasses.
    class BreadcrumbsComponent < DesignSystem::BaseComponent
      def initialize(breadcrumbs:)
        super()
        @breadcrumbs = breadcrumbs
      end

      attr_reader :breadcrumbs

      def call
        safe_join(breadcrumbs.map { |breadcrumb| link_to_unless_current(breadcrumb[:label], breadcrumb[:path]) },
                  ' > ')
      end
    end
  end
end
