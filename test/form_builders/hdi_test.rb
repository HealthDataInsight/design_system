require 'test_helper'
require 'design_system/form_builders/hdi'
require 'design_system/registry'

module FormBuilders
  class HdiTest < ActionView::TestCase
    def setup
      @brand = 'hdi'
      @builder = DesignSystem::FormBuilders::Hdi
    end

    test 'self.brand' do
      assert_equal @brand, @builder.brand
    end

    test 'Registry.form_builder returns Hdi form builder' do
      assert_equal DesignSystem::FormBuilders::Hdi,
                   DesignSystem::Registry.form_builder(@brand)
    end
  end
end
