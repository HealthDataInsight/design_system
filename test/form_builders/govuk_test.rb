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

    test 'ds_password_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group.#{@brand}-password-input") do
          assert_select("label.#{@brand}-label", 'Title')

          assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
            input = assert_select('input[type=password]').first
            assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input", input['class']
            assert_equal 'false', input['spellcheck']
            assert_equal 'current-password', input['autocomplete']
            assert_equal 'none', input['autocapitalize']
            assert_nil input['value']

            button = assert_select('button[type=button]').first
            assert_equal "#{@brand}-button", button['data-module']
            assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
                         button['class']
            assert_equal 'assistant_title', button['aria-controls']
            assert_equal 'Show password', button['aria-label']
            assert_equal 'hidden', button['hidden']
          end
        end
      end
    end

    test 'ds_password_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group.#{@brand}-password-input") do
          assert_select("label.#{@brand}-label", 'Title')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant_title_hint', hint['id']

          assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
            input = assert_select('input[type=password]').first
            assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input", input['class']
            assert_equal 'false', input['spellcheck']
            assert_equal 'current-password', input['autocomplete']
            assert_equal 'none', input['autocapitalize']
            assert_nil input['value']
            assert_equal 'assistant_title_hint', input['aria-describedby']

            button = assert_select('button[type=button]').first
            assert_equal "#{@brand}-button", button['data-module']
            assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
                         button['class']
            assert_equal 'assistant_title', button['aria-controls']
            assert_equal 'Show password', button['aria-label']
            assert_equal 'hidden', button['hidden']
          end
        end
      end
    end

    test 'ds_password_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title, class: 'geoff', placeholder: 'bar')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group.#{@brand}-password-input") do
          assert_select("label.#{@brand}-label", 'Title')

          assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
            input = assert_select('input[type=password][placeholder=bar]').first
            assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input geoff", input['class']
            assert_equal 'false', input['spellcheck']
            assert_equal 'current-password', input['autocomplete']
            assert_equal 'none', input['autocapitalize']
            assert_nil input['value']

            button = assert_select('button[type=button]').first
            assert_equal "#{@brand}-button", button['data-module']
            assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
                         button['class']
            assert_equal 'assistant_title', button['aria-controls']
            assert_equal 'Show password', button['aria-label']
            assert_equal 'hidden', button['hidden']
          end
        end
      end
    end

    test 'ds_password_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_password_field(:title)
        end

        assert_select('form') do
          assert_select("div.#{@brand}-form-group.#{@brand}-password-input") do
            assert_select("label.#{@brand}-label", 'Title, yarr')

            assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
              input = assert_select('input[type=password]').first
              assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input", input['class']
              assert_equal 'false', input['spellcheck']
              assert_equal 'current-password', input['autocomplete']
              assert_equal 'none', input['autocapitalize']
              assert_nil input['value']

              button = assert_select('button[type=button]').first
              assert_equal "#{@brand}-button", button['data-module']
              assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
                           button['class']
              assert_equal 'assistant_title', button['aria-controls']
              assert_equal 'Show password', button['aria-label']
              assert_equal 'hidden', button['hidden']
            end
          end
        end
      end
    end
  end
end
