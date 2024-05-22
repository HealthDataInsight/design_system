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

  test 'design_system returns correct instance' do
    brand = 'govuk'
    controller.stubs(brand: brand)
    assert_equal @registry.design_system(brand, self).brand, design_system.brand
  end

  test 'design_system responds to block' do
    block_excuted = false

    controller.stubs(brand: 'govuk')
    design_system do |_ds|
      block_excuted = true
    end
    assert block_excuted
  end
end
