require 'test_helper'

# This is the test function for the registry
class DesignSystemRegistryTest < ActiveSupport::TestCase
  setup do
    @registry = DesignSystem::Registry
  end

  test 'loads design systems' do
    assert_equal 2, @registry.design_systems.count
  end

  test 'can register/unregister a new design system' do
    @registry.unregister('govuk')
    assert_equal 1, @registry.design_systems.count
    @registry.register('govuk')
    assert_equal 2, @registry.design_systems.count
  end

  test 'component returns the Govuk view component class' do
    assert_equal DesignSystem::Govuk::PanelComponent,
                 @registry.component('govuk', :panel)
  end

  test 'component returns the Nhsuk view component class' do
    assert_equal DesignSystem::Nhsuk::PanelComponent,
                 @registry.component('nhsuk', :panel)
  end

  test 'component accepts a string name' do
    assert_equal DesignSystem::Govuk::PanelComponent,
                 @registry.component('govuk', 'panel')
  end

  test 'component raises ArgumentError for an unknown brand' do
    error = assert_raises(ArgumentError) { @registry.component('not_a_brand', :panel) }
    assert_match(/Unknown brand/, error.message)
  end

  test 'component raises ArgumentError for an unknown component' do
    error = assert_raises(ArgumentError) { @registry.component('govuk', :not_a_component) }
    assert_match(/Unknown component/, error.message)
  end

  def teardown
    @registry = nil
  end
end
