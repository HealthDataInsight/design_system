require 'design_system/registry'

module DesignSystemHelper
  # This method provides access to the current design system adapter
  def design_system
    instance = DesignSystem::Registry.design_system(controller.brand, self)

    yield instance

    instance.render
  end
end
