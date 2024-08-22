require_relative 'base'
require_relative 'components/hdi/breadcrumbs'
require_relative 'components/hdi/headings'
require_relative 'components/hdi/table'

# Extend the design system module to include Hdi
module DesignSystem
  # This is the HDI branded adapter for the design system
  class Hdi < Base
    include Components::Hdi::Breadcrumbs
    include Components::Hdi::Headings
    include Components::Hdi::Table

    # private

    # def render_main_container(&)
    #   content_tag(:div, class: 'mx-auto w-full', &)
    # end
  end

  Registry.register(Hdi)
end
