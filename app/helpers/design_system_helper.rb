require 'design_system/registry'

# The helpers for the design system
module DesignSystemHelper
  include ActionView::Helpers::FormHelper

  def brand
    controller.send(:brand)
  end

  # This method provides access to the current design system adapter
  def ds_fixed_elements
    instance = DesignSystem::Registry.builder(brand, 'fixed_elements', self)

    if block_given?
      yield instance

      instance.render
    else
      instance
    end
  end

  def ds_form_builder
    DesignSystem::Registry.form_builder(brand)
  end

  def ds_form_with_branding(model: nil, scope: nil, url: nil, format: nil, **options, &)
    ds_form_without_branding(model:, scope:, url:, format:, builder: ds_form_builder, **options, &)
  end
  alias ds_form_without_branding form_with
  alias form_with ds_form_with_branding

  def ds_table(&)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.builder(brand, 'table', self).render_table(&)
  end
end
