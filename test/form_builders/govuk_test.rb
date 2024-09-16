require 'test_helper'
require 'design_system/form_builders/govuk'
require_relative 'concerns/govuk_form_builder_testable'

module FormBuilders
  class GovukTest < ActionView::TestCase
    include GovukFormBuilderTestable

    def setup
      @brand = 'govuk'
      @builder = DesignSystem::FormBuilders::Govuk    
    end

    test 'Registry.form_builder returns Govuk form builder' do
      assert_equal DesignSystem::FormBuilders::Govuk,
                   DesignSystem::Registry.form_builder(@brand)
    end
  end
end
