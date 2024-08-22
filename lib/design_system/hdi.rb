require_relative 'base'
require_relative 'builders/hdi/breadcrumbs'
require_relative 'builders/hdi/headings'
require_relative 'builders/hdi/table'

# Extend the design system module to include Hdi
module DesignSystem
  # This is the HDI branded adapter for the design system
  class Hdi < Base
    include Builders::Hdi::Breadcrumbs
    include Builders::Hdi::Headings
    include Builders::Hdi::Table

    # private

    # def render_main_container(&)
    #   content_tag(:div, class: 'mx-auto w-full', &)
    # end
  end

  Registry.register(Hdi)
end
