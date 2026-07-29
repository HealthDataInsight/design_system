module DesignSystem
  module Generic
    # Breadcrumb trail rendered into the :breadcrumbs content_for slot by the
    # fixed-elements builder. Brands own the markup via their own templates.
    class BreadcrumbsComponent < DesignSystem::BaseComponent
      def initialize(breadcrumbs:)
        super()
        @breadcrumbs = breadcrumbs
      end

      attr_reader :breadcrumbs

      def current_page_aria(breadcrumb)
        helpers.current_page?(breadcrumb[:path]) ? 'page' : nil
      end
    end
  end
end
