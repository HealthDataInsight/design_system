require 'test_helper'
require 'design_system/form_builders/nhsuk'
require_relative 'concerns/govuk_form_builder_testable'

module FormBuilders
  class NhsukTest < ActionView::TestCase
    include GovukFormBuilderTestable

    def setup
      @brand = 'nhsuk'
      @builder = DesignSystem::FormBuilders::Nhsuk
    end

    test 'Registry.form_builder returns Nhsuk form builder' do
      assert_equal DesignSystem::FormBuilders::Nhsuk,
                   DesignSystem::Registry.form_builder(@brand)
    end
  end
end
