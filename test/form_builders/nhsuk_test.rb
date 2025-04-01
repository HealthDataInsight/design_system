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

    test 'ds_password_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group[data-controller='ds--show-password']") do
          assert_select("label.#{@brand}-label", 'Title')

          input = assert_select('input[type=password]').first
          assert_equal "#{@brand}-input", input['class']
          assert_equal 'current-password', input['autocomplete']
          assert_equal 'password', input['data-ds--show-password-target']
          assert_nil input['value']

          button = assert_select('button[type=button]').first
          assert_equal "#{@brand}-button #{@brand}-button--secondary", button['class']
          assert_equal 'Show password', button['aria-label']
          assert_equal "#{@brand}-button", button['data-module']
          assert_equal 'click->ds--show-password#toggle', button['data-action']
        end
      end
    end
  end
end
