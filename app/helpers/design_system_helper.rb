require 'design_system/registry'

# The helpers for the design system
module DesignSystemHelper
  include ActionView::Helpers::FormHelper

  def brand
    controller.send(:brand)
  end

  # This method provides access to the current design system adapter
  def design_system
    instance = DesignSystem::Registry.design_system(brand, self)

    if block_given?
      yield instance

      instance.render
    else
      instance
    end
  end

  def ds_table(&)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.table(brand, self, &)
  end
end
