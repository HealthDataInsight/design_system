require 'test_helper'
require 'design_system/form_builders/hdi'
require 'design_system/registry'
require_relative 'concerns/govuk_form_builder_testable'

module FormBuilders
  class HdiTest < ActionView::TestCase
    include GovukFormBuilderTestable

    def setup
      @brand = 'hdi'
      @builder = DesignSystem::FormBuilders::Hdi
    end

    test 'Registry.form_builder returns Hdi form builder' do
      assert_equal DesignSystem::FormBuilders::Hdi,
                   DesignSystem::Registry.form_builder(@brand)
    end
  end
end
