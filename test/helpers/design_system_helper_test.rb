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

    assert_select 'body[data-ds-brand="hdi"]'
    assert_select 'body[data-ds-layout="application"]'
  end

  test 'ds_render_template renders left_panel custom layout upon request' do
    @controller.stubs(
      brand: 'hdi',
      navigation_items: [{ label: 'Test Item', path: '/test' }]
    )

    @output_buffer = ds_render_template('left_panel')

    assert_select 'body[data-ds-brand="hdi"]'
    assert_select 'body[data-ds-layout="left_panel"]'
  end
end
