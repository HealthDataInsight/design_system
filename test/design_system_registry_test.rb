require 'test_helper'

# This is the test function for the registry
class DesignSystemRegistryTest < ActiveSupport::TestCase
  setup do
    @registry = DesignSystem::Registry
  end

  test 'loads design systems' do
    assert_equal 4, @registry.design_systems.count
  end

  test 'can register/unregister a new design system' do
    @registry.unregister('govuk')
    assert_equal 3, @registry.design_systems.count
    @registry.register(DesignSystem::Govuk)
    assert_equal 4, @registry.design_systems.count
  end

  def teardown
    @registry = nil
  end
end
