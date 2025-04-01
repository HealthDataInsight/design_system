require 'test_helper'
require 'design_system/form_builders/ndrsuk'
require_relative 'concerns/govuk_form_builder_testable'

module FormBuilders
  class NdrsukTest < ActionView::TestCase
    include GovukFormBuilderTestable

    def setup
      @brand = 'ndrsuk'
      @builder = DesignSystem::FormBuilders::Ndrsuk
    end

    test 'Registry.form_builder returns Ndrsuk form builder' do
      assert_equal DesignSystem::FormBuilders::Ndrsuk,
                   DesignSystem::Registry.form_builder(@brand)
    end
  end
end
