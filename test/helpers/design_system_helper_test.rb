require 'test_helper'
require_relative '../../app/helpers/design_system_helper'

class DesignSystemHelperTest < ActionView::TestCase
  def setup
    @registry = DesignSystem::Registry
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
    assert_equal @registry.fixed_elements(brand, self).brand, ds_fixed_elements.brand
  end

  test 'ds_fixed_elements responds to block' do
    block_excuted = false

    controller.stubs(brand: 'govuk')
    ds_fixed_elements do |_ds|
      block_excuted = true
    end
    assert block_excuted
  end
end
