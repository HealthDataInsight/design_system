require_relative 'base'
require 'design_system/components/hdi/breadcrumbs'
require 'design_system/components/hdi/table'

# Extend the design system module to include Hdi
module DesignSystem
  # This is the HDI branded adapter for the design system
  class Hdi < Base
    include DesignSystem::Components::Hdi::Breadcrumbs
    include DesignSystem::Components::Hdi::Table

    private

    # def render_main_container(&)
    #   content_tag(:div, class: 'mx-auto w-full', &)
    # end

    def render_main_heading
      content_tag(:h1, @main_heading, class: 'text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl')
    end
  end

  Registry.register(Hdi)
end
