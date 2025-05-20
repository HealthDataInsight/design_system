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

    test 'ds_password_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group[data-controller='ds--show-password']") do
          assert_select("label.#{@brand}-label", 'Title')

          input = assert_select('input[type=password]').first
          assert_includes input['class'], "#{@brand}-input"
          assert_includes input['class'], "#{@brand}-password-field__input"
          assert_equal 'current-password', input['autocomplete']
          assert_equal 'password', input['data-ds--show-password-target']
          assert_nil input['value']

          button = assert_select('button[type=button]').first
          assert_equal "#{@brand}-password-field__button", button['class']
          assert_equal 'Show password', button['aria-label']
          assert_equal "#{@brand}-button", button['data-module']
          assert_equal 'click->ds--show-password#toggle', button['data-action']
          assert_select button, 'svg.password-field__icon'
        end
      end
    end

    test 'ds_password_field with error' do
      assistant = Assistant.new
      refute assistant.valid?

      @output_buffer = form_with(model: assistant, builder: @builder) do |f|
        f.ds_password_field(:title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group[data-controller='ds--show-password']") do
          assert_select("label.#{@brand}-label", 'Title')

          input = assert_select('input[type=password]').first
          assert_includes input['class'], "#{@brand}-input"
          assert_includes input['class'], "#{@brand}-password-field__input"
          assert_includes input['class'], "#{@brand}-input--error"
          assert_equal 'current-password', input['autocomplete']
          assert_equal 'password', input['data-ds--show-password-target']
          assert_nil input['value']
        end
      end
    end
  end
end
