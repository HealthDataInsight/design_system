require 'test_helper'
require_relative '../../app/helpers/design_system_helper'
require_relative '../../app/helpers/hdi_helper'

class DesignSystemHelperTest < ActionView::TestCase
  def setup
    @registry = DesignSystem::Registry
    @controller.class.helper HdiHelper
  end

  def teardown
    @registry = nil
  end

  test 'brand' do
    controller.stubs(brand: 'geoff')

    assert_equal 'geoff', brand
  end

  test 'ds_fixed_elements returns correct instance' do
    brand = 'govuk'
    controller.stubs(brand:)
    assert_equal @registry.builder(brand, 'fixed_elements', self).brand, ds_fixed_elements.brand
    assert_equal @registry.builder(brand, 'FixedElements', self).brand, ds_fixed_elements.brand
  end

  test 'ds_fixed_elements responds to block' do
    block_excuted = false

    controller.stubs(brand: 'govuk')
    ds_fixed_elements do |_ds|
      block_excuted = true
    end
    assert block_excuted
  end

  test 'ds_render_template default to application layout' do
    @controller.stubs(
      brand: 'hdi',
      navigation_items: [{ label: 'Test Item', path: '/test' }]
    )

    @output_buffer = ds_render_template

    # head should be inserted for all layouts
    assert_includes @output_buffer, 'tailwind.config'
    # body uses the default layout
    assert_includes @output_buffer, 'HDI Portal'
    assert_includes @output_buffer, 'Test Item'
  end

  test 'ds_render_template renders left_panel custom layout upon request' do
    @controller.stubs(
      brand: 'hdi',
      navigation_items: [{ label: 'Test Item', path: '/test' }]
    )

    @output_buffer = ds_render_template('left_panel')

    # head should be inserted for all layouts
    assert_includes @output_buffer, 'tailwind.config'
    # body uses the left_panel layout
    assert_includes @output_buffer, 'https://images.unsplash.com/photo-1496917756835-20cb06e75b4e'
    refute_includes @output_buffer, 'Test Item'
  end
end
