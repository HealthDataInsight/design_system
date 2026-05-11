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

  test 'registered? returns true for registered brands' do
    assert @registry.registered?('govuk')
    assert @registry.registered?('nhsuk')
  end

  test 'registered? returns false for unknown brands' do
    assert_not @registry.registered?('unknown')
    assert_not @registry.registered?(nil)
    assert_not @registry.registered?('')
  end

  test 'form_builder raises ArgumentError for unregistered brand' do
    assert_raises(ArgumentError) { @registry.form_builder('unknown') }
    assert_raises(ArgumentError) { @registry.form_builder('Object') }
    assert_raises(ArgumentError) { @registry.form_builder(nil) }
  end

  test 'form_builder returns the brand form builder for registered brands' do
    assert_equal DesignSystem::Govuk::FormBuilder, @registry.form_builder('govuk')
    assert_equal DesignSystem::Nhsuk::FormBuilder, @registry.form_builder('nhsuk')
  end

  test 'builder raises ArgumentError for unregistered brand' do
    assert_raises(ArgumentError) { @registry.builder('unknown', 'heading', nil) }
  end

  def teardown
    @registry = nil
  end
end
