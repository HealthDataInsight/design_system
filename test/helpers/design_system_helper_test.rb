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

  test 'ds_form_builder returns govuk form builder' do
    assert_equal DesignSystem::FormBuilders::Govuk,
                 DesignSystem::Registry.form_builder('govuk')
  end

  test 'ds_form_builder returns hdi form builder' do
    assert_equal DesignSystem::FormBuilders::Hdi,
                 DesignSystem::Registry.form_builder('hdi')
  end

  test 'ds_form_builder returns ndrsuk form builder' do
    assert_equal DesignSystem::FormBuilders::Ndrsuk,
                 DesignSystem::Registry.form_builder('ndrsuk')
  end

  test 'ds_form_builder returns nhsuk form builder' do
    assert_equal DesignSystem::FormBuilders::Nhsuk,
                 DesignSystem::Registry.form_builder('nhsuk')
  end

  test 'form_with sets the govuk form builder' do
    controller.stubs(brand: 'govuk')

    form_with(url: root_path) do |ds|
      assert_kind_of DesignSystem::FormBuilders::Govuk, ds
    end
  end

  test 'form_with sets the hdi form builder' do
    controller.stubs(brand: 'hdi')

    form_with(url: root_path) do |ds|
      assert_kind_of DesignSystem::FormBuilders::Hdi, ds
    end
  end

  test 'form_with sets the ndrsuk form builder' do
    controller.stubs(brand: 'ndrsuk')

    form_with(url: root_path) do |ds|
      assert_kind_of DesignSystem::FormBuilders::Ndrsuk, ds
    end
  end

  test 'form_with sets the nhsuk form builder' do
    controller.stubs(brand: 'nhsuk')

    form_with(url: root_path) do |ds|
      assert_kind_of DesignSystem::FormBuilders::Nhsuk, ds
    end
  end
end
