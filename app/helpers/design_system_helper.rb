# frozen_string_literal: true

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

  def ds_table(&)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.builder(brand, 'table', self).render_table(&)
  end

  def ds_tab(&)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.builder(brand, 'tab', self).render_tabs(&)
  end

  def ds_button(text, style = 'primary', options = {})
    DesignSystem::Registry.builder(brand, 'button', self).render_button(text, style, options)
  end

  def ds_start_button(text, href = '#', options = {})
    DesignSystem::Registry.builder(brand, 'button', self).render_start_button(text, href, options)
  end
end
