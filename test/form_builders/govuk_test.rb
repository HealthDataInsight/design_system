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

    test 'ds_hidden_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_hidden_field(:title, value: assistants(:one).title, show_text: 'Show text')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_label :title, nil, 'Title'
          assert_select("input[class='#{@brand}-visually-hidden'][type='hidden'][value='Lorem ipsum dolor sit amet']")
          assert_select("span.#{@brand}-body-m", 'Show text')
        end
      end
    end

    test 'ds_hidden_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_hidden_field(:title, value: assistants(:one).title, show_text: 'Show text', class: 'geoff', 'data-foo': 'bar')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_label :title, nil, 'Title'
          assert_select("input[class='geoff #{@brand}-visually-hidden'][type='hidden'][value='Lorem ipsum dolor sit amet'][data-foo=bar]")
          assert_select("span.#{@brand}-body-m", 'Show text')
        end
      end
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

    test 'label hidden' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id, options_for_select(Department.all.map { |department| [department.title, department.id] }), label: { hidden: true })
      end

      assert_select("label.#{@brand}-label span.#{@brand}-visually-hidden", text: 'What is your department?')
    end

    test 'legend hidden' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_date_field(:date_of_birth, hint: "Demo for ds_date_field", date_of_birth: true, legend: { text:'Find me', size: nil, hidden: true })
      end

      assert_select("legend.#{@brand}-fieldset__legend.#{@brand}-visually-hidden", text: 'Find me')
    end
  end
end
