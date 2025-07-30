require 'test_helper'
require 'design_system/ndrsuk/form_builder'
require_relative '../govuk/concerns/govuk_form_builder_testable'

module Ndrsuk
  class FormBuilderTest < ActionView::TestCase
    include GovukFormBuilderTestable

    def setup
      @brand = 'ndrsuk'
      @builder = DesignSystem::Ndrsuk::FormBuilder
      @controller.stubs(:brand).returns(@brand)
    end

    test 'Registry.form_builder returns Ndrsuk form builder' do
      assert_equal DesignSystem::Ndrsuk::FormBuilder,
                   DesignSystem::Registry.form_builder(@brand)
    end
  end
end
