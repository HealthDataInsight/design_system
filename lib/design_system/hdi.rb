require_relative 'base'
require 'design_system/components/hdi/breadcrumbs'
require 'design_system/components/hdi/headings'

# Extend the design system module to include Hdi
module DesignSystem
  # This is the HDI branded adapter for the design system
  class Hdi < Base
    include DesignSystem::Components::Hdi::Breadcrumbs
    include DesignSystem::Components::Hdi::Headings

    # private

    # def render_main_container(&)
    #   content_tag(:div, class: 'mx-auto w-full', &)
    # end
  end

  Registry.register(Hdi)
end
