require 'design_system/govuk/test_helpers/form_builder_assertions_helper'

module DesignSystem
  module Govuk
    class DummyModel
      include ActiveModel::Model

      attr_accessor :role
    end

    module DummyAdmin
      class DummyUser
        include ActiveModel::Model

        attr_accessor :status
      end
    end

    module TestHelpers
      # This concern manages choosing the relevant layout for our given design system
      module FormBuilderTestable
        include DesignSystemHelper
        include DesignSystem::Govuk::TestHelpers::FormBuilderAssertionsHelper
        extend ActiveSupport::Concern

        included do
          setup do
            I18n.backend.store_translations(:en, {
                                              helpers: {
                                                options: {
                                                  assistant: {
                                                    terms_agreed: {
                                                      true: 'Yes, I agree'
                                                    }
                                                  },
                                                  'design_system/govuk/dummy_model': {
                                                    role: {
                                                      admin: 'Administrator'
                                                    }
                                                  },
                                                  'design_system/govuk/dummy_admin/dummy_user': {
                                                    status: {
                                                      active: 'Still in the game'
                                                    }
                                                  }
                                                }
                                              }
                                            })
          end

          test 'self.brand' do
            assert_equal @brand, @builder.brand
          end

          test 'ds_check_box with single checkbox' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_check_boxes_fieldset(:desired_filling, { multiple: true, legend: { size: 'm' } }) do
                f.ds_check_box(:desired_filling, { multiple: true }, :pastrami)
              end
            end

            assert_form_group do
              assert_select("fieldset.#{@brand}-fieldset") do
                assert_select("legend.#{@brand}-fieldset__legend.#{@brand}-fieldset__legend--m",
                              'What do you want in your sandwich?')

                input = assert_select('input').first
                assert_equal 'assistant_desired_filling', input['id']
                assert_equal 'assistant[desired_filling][]', input['name']
                assert_equal '', input['value']
                assert_equal 'hidden', input['type']
                assert_equal 'off', input['autocomplete']

                assert_select("div.#{@brand}-checkboxes[data-module='#{@brand}-checkboxes']") do
                  assert_select("div.#{@brand}-checkboxes__item") do
                    input = assert_select("input.#{@brand}-checkboxes__input").first
                    assert_equal 'assistant_desired_filling_pastrami', input['id']
                    assert_equal 'assistant[desired_filling][]', input['name']
                    assert_equal 'pastrami', input['value']
                    assert_equal 'checkbox', input['type']

                    label = assert_select("label.#{@brand}-label.#{@brand}-checkboxes__label[for='assistant_desired_filling_pastrami']").first
                    assert_equal 'pastrami', label.text.strip
                  end
                end
              end
            end
          end

          test 'ds_check_box item translation for activerecord attributes' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_check_box(:terms_agreed, {}, :true)
            end

            assert_select('form') do
              assert_select("div.#{@brand}-checkboxes__item") do
                assert_select("label.#{@brand}-label.#{@brand}-checkboxes__label", 'Yes, I agree')
              end
            end
          end

          test 'ds_check_box item translation for activemodel attributes' do
            @output_buffer = ds_form_with(model: DummyModel.new, builder: @builder, url: '/') do |f|
              f.ds_check_box(:role, {}, :admin)
            end

            assert_select('form') do
              assert_select("div.#{@brand}-checkboxes__item") do
                assert_select("label.#{@brand}-label.#{@brand}-checkboxes__label", 'Administrator')
              end
            end
          end

          test 'ds_check_box item translation for activemodel attributes with nested attributes' do
            @output_buffer = ds_form_with(model: DummyAdmin::DummyUser.new, builder: @builder, url: '/') do |f|
              f.ds_check_box(:status, {}, :active)
            end

            assert_select('form') do
              assert_select("div.#{@brand}-checkboxes__item") do
                assert_select("label.#{@brand}-label.#{@brand}-checkboxes__label", 'Still in the game')
              end
            end
          end

          test 'ds_check_box item with dot in value is not incorrectly translated' do
            value_with_dot = 'Made up dummy values (e.g. see with dot it works)'
            @output_buffer = ds_form_with(model: DummyModel.new, builder: @builder, url: '/') do |f|
              f.ds_check_box(:role, {}, value_with_dot)
            end

            assert_select('form') do
              assert_select("div.#{@brand}-checkboxes__item") do
                label = assert_select("label.#{@brand}-label.#{@brand}-checkboxes__label").first
                assert_equal value_with_dot, label.text.strip
              end
            end
          end

          test 'ds_check_box item ending with dot in value is not incorrectly translated' do
            value_ending_with_dot = 'Made up dummy values with a full stop.'
            @output_buffer = ds_form_with(model: DummyModel.new, builder: @builder, url: '/') do |f|
              f.ds_check_box(:role, {}, value_ending_with_dot)
            end

            assert_select('form') do
              assert_select("div.#{@brand}-checkboxes__item") do
                label = assert_select("label.#{@brand}-label.#{@brand}-checkboxes__label").first
                assert_equal value_ending_with_dot, label.text.strip
              end
            end
          end

          test 'ds_collection_select' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_collection_select(:department_id, Department.all, :id, :title)
            end

            assert_form_group do
              assert_label :department_id, nil, 'What is your department?'

              select = assert_select("select.#{@brand}-select").first
              assert_equal 'assistant_department_id', select['id']
              assert_equal 'assistant[department_id]', select['name']

              options = assert_select('option')
              assert_equal '1', options[0]['value']
              assert_equal 'Sales', options[0].text.strip
              assert_equal '2', options[1]['value']
              assert_equal 'Marketing', options[1].text.strip
              assert_equal '3', options[2]['value']
              assert_equal 'Finance', options[2].text.strip
            end
          end

          test 'ds_collection_select with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_collection_select(:department_id, Department.all, :id, :title, hint: 'This is a hint')
            end

            assert_form_group do
              assert_label :department_id, nil, 'What is your department?'
              assert_hint :department_id, nil, 'This is a hint'

              select = assert_select("select.#{@brand}-select").first
              assert_equal 'assistant_department_id_hint', select['aria-describedby']
            end
          end

          test 'ds_collection_select with html options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_collection_select(:department_id, Department.all, :id, :title, {},
                                     { class: 'geoff', placeholder: 'bar' })
            end

            assert_form_group do
              assert_label :department_id, nil, 'What is your department?'

              select = assert_select("select.#{@brand}-select.geoff[placeholder=bar]").first
              assert_equal 'assistant_department_id', select['id']
              assert_equal 'assistant[department_id]', select['name']

              options = assert_select('option')
              assert_equal '1', options[0]['value']
              assert_equal 'Sales', options[0].text.strip
            end
          end

          test 'ds_collection_select with custom label size' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_collection_select(:department_id, Department.all, :id, :title, label: { size: 'l' })
            end

            assert_form_group do
              assert_select("label.#{@brand}-label.#{@brand}-label--l", text: 'What is your department?')
            end
          end

          test 'ds_date_field' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_date_field(:date_of_birth, hint: 'This is a hint')
            end

            assert_form_group do
              assert_select("fieldset.#{@brand}-fieldset[aria-describedby=assistant_date_of_birth_hint]") do
                legend = assert_select("legend.#{@brand}-fieldset__legend").first
                assert_equal 'What is your date of birth?', legend.text.strip

                assert_hint :date_of_birth, nil, 'This is a hint'

                date_input = assert_select("div.#{@brand}-date-input").first
                assert date_input, 'Date input container not found'

                # Test day input
                assert_select("div.#{@brand}-date-input__item:nth-child(1)")
                assert_select("div.#{@brand}-form-group") do
                  day_label = assert_select("label.#{@brand}-label[for='assistant_date_of_birth_3i']").first
                  assert_equal 'Day', day_label.text.strip

                  day_input = assert_select("input.#{@brand}-input.#{@brand}-date-input__input.#{@brand}-input--width-2").first
                  assert_equal 'assistant_date_of_birth_3i', day_input['id']
                  assert_equal 'assistant[date_of_birth(3i)]', day_input['name']
                  assert_equal 'text', day_input['type']
                  assert_equal 'numeric', day_input['inputmode']
                end

                # Test month input
                assert_select("div.#{@brand}-date-input__item:nth-child(2)")
                assert_select("div.#{@brand}-form-group") do
                  month_label = assert_select("label.#{@brand}-label[for='assistant_date_of_birth_2i']").first
                  assert_equal 'Month', month_label.text.strip

                  month_input = assert_select("input.#{@brand}-input.#{@brand}-date-input__input.#{@brand}-input--width-2").last
                  assert_equal 'assistant_date_of_birth_2i', month_input['id']
                  assert_equal 'assistant[date_of_birth(2i)]', month_input['name']
                  assert_equal 'text', month_input['type']
                  assert_equal 'numeric', month_input['inputmode']
                end

                # Test year input
                assert_select("div.#{@brand}-date-input__item:nth-child(3)")
                assert_select("div.#{@brand}-form-group") do
                  year_label = assert_select("label.#{@brand}-label[for='assistant_date_of_birth_1i']").first
                  assert_equal 'Year', year_label.text.strip

                  year_input = assert_select("input.#{@brand}-input.#{@brand}-date-input__input.#{@brand}-input--width-4").first
                  assert_equal 'assistant_date_of_birth_1i', year_input['id']
                  assert_equal 'assistant[date_of_birth(1i)]', year_input['name']
                  assert_equal 'text', year_input['type']
                  assert_equal 'numeric', year_input['inputmode']
                end
              end
            end
          end

          test 'ds_date_field with custom legend size' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_date_field(:date_of_birth, legend: { size: nil })
            end

            assert_form_group do
              assert_select("legend.#{@brand}-fieldset__legend", text: 'What is your date of birth?')
            end
          end

          test 'ds_email_field' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_email_field(:email)
            end

            assert_form_group do
              assert_label :email, nil, 'What is your email?'
              assert_input :email, type: :email, value: 'one@ex.com'
            end
          end

          test 'ds_email_field with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_email_field(:email, hint: 'This is a hint')
            end

            assert_form_group do
              assert_label :email, nil, 'What is your email?'
              assert_hint :email, nil, 'This is a hint'
              assert_input :email, type: :email, value: 'one@ex.com',
                                   attributes: { 'aria-describedby' => 'assistant_email_hint' }
            end
          end

          test 'ds_email_field with options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_email_field(:email, class: 'geoff', placeholder: 'bar')
            end

            assert_form_group do
              assert_label :email, nil, 'What is your email?'
              assert_input :email, type: :email, value: 'one@ex.com',
                                   classes: ['geoff'],
                                   attributes: { placeholder: 'bar' }
            end
          end

          test 'ds_email_field with pirate locale' do
            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
                f.ds_email_field(:email)
              end

              assert_form_group do
                assert_label :email, nil, 'Email, yarr'
              end
            end
          end

          test 'ds_error_summary' do
            assistant = Assistant.new(
              title: '',
              department_id: nil,
              password: assistants(:one).password,
              date_of_birth: assistants(:one).date_of_birth,
              phone: assistants(:one).phone
            )
            assistant.valid?

            @output_buffer = ds_form_with(model: assistant, builder: @builder, &:ds_error_summary)

            assert_select("div.#{@brand}-error-summary[data-module='#{@brand}-error-summary']") do
              assert_select("div[role='alert']") do
                assert_select("h2.#{@brand}-error-summary__title", 'There is a problem')
                assert_select("div.#{@brand}-error-summary__body") do
                  assert_select("ul.#{@brand}-list.#{@brand}-error-summary__list") do
                    assert_select('li') do
                      assert_select("a[href='#assistant_title_error']", 'Enter a title')
                    end
                    assert_select('li') do
                      assert_select("a[href='#assistant_department_id_error']", 'Select a department')
                    end
                  end
                end
              end
            end
          end

          test 'ds_error_summary with title' do
            assistant = Assistant.new(
              title: '',
              department_id: nil,
              password: assistants(:one).password,
              date_of_birth: assistants(:one).date_of_birth,
              phone: assistants(:one).phone
            )
            assistant.valid?

            @output_buffer = ds_form_with(model: assistant, builder: @builder) do |f|
              f.ds_error_summary('Oops')
            end

            assert_select("div.#{@brand}-error-summary") do
              assert_select("h2.#{@brand}-error-summary__title", 'Oops')
              assert_select("div.#{@brand}-error-summary__body") do
                assert_select("ul.#{@brand}-list.#{@brand}-error-summary__list") do
                  assert_select('li') do
                    assert_select("a[href='#assistant_title_error']", 'Enter a title')
                  end
                  assert_select('li') do
                    assert_select("a[href='#assistant_department_id_error']", 'Select a department')
                  end
                end
              end
            end
          end

          test 'ds_error_summary with options' do
            assistant = Assistant.new(
              title: assistants(:one).title,
              department_id: assistants(:one).department_id,
              password: assistants(:one).password,
              date_of_birth: assistants(:one).date_of_birth,
              phone: nil,
              email: nil
            )
            assistant.valid?

            @output_buffer = ds_form_with(model: assistant, builder: @builder) do |f|
              f.ds_error_summary(link_base_errors_to: :email)
            end

            assert_select("div.#{@brand}-error-summary") do
              assert_select("div[role='alert']") do
                assert_select("h2.#{@brand}-error-summary__title", 'There is a problem')
                assert_select("div.#{@brand}-error-summary__body") do
                  assert_select("ul.#{@brand}-list.#{@brand}-error-summary__list") do
                    assert_select('li') do
                      assert_select("a[href='#assistant_email']", 'Enter a telephone number or email address')
                    end
                  end
                end
              end
            end
          end

          test 'ds_error_summary with html options' do
            assistant = Assistant.new(
              title: assistants(:one).title,
              department_id: assistants(:one).department_id,
              password: assistants(:one).password,
              date_of_birth: assistants(:one).date_of_birth,
              phone: nil,
              email: nil
            )
            assistant.valid?

            @output_buffer = ds_form_with(model: assistant, builder: @builder) do |f|
              f.ds_error_summary(class: 'geoff', 'data-foo': 'bar')
            end

            assert_select("div.#{@brand}-error-summary.geoff[data-foo=bar]") do
              assert_select("div[role='alert']") do
                assert_select("h2.#{@brand}-error-summary__title", 'There is a problem')
              end
            end
          end

          test 'ds_error_summary with pirate locale' do
            assistant = Assistant.new(
              title: assistants(:one).title,
              department_id: assistants(:one).department_id,
              password: assistants(:one).password,
              date_of_birth: assistants(:one).date_of_birth,
              phone: nil,
              email: nil
            )
            assistant.valid?

            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistant, builder: @builder, &:ds_error_summary)

              assert_select("div.#{@brand}-error-summary") do
                assert_select("div[role='alert']") do
                  assert_select("h2.#{@brand}-error-summary__title", 'There is a problem, yarr')
                end
              end
            end
          end

          # NOTE: We test the file field without ActiveStorage to keep the design system lightweight.
          # We only test the HTML structure and attributes, not the actual file handling functionality.
          test 'ds_file_field' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_file_field(:cv)
            end

            assert_form_group do
              assert_label :cv, nil, 'Upload a file'
              assert_file_upload :cv, type: :file
            end
          end

          test 'ds_file_field with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_file_field(:cv, hint: 'This is a hint')
            end

            assert_form_group do
              assert_label :cv, nil, 'Upload a file'
              assert_hint :cv, nil, 'This is a hint'
              assert_file_upload :cv, type: :file, attributes: { 'aria-describedby' => 'assistant_cv_hint' }
            end
          end

          test 'ds_label' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_label(:title)
            end

            assert_select('form') do
              assert_label :title, nil, 'Title'
            end
          end

          test 'ds_label with content and options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_label(:title, 'Titlezzz', class: 'bob', 'data-foo': 'bar')
            end

            assert_select('form') do
              assert_select("label.#{@brand}-label[data-foo=bar]", 'Titlezzz')
            end
          end

          test 'ds_label with pirate locale' do
            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
                f.ds_label(:title)
              end

              assert_select('form') do
                assert_label :title, nil, 'Title, yarr'
              end
            end
          end

          test 'ds_number_field' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_number_field(:age)
            end

            assert_form_group do
              assert_label :age, nil, 'What is your age?'
              assert_input :age, type: :number, value: '30'
            end
          end

          test 'ds_number_field with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_number_field(:age, hint: 'This is a hint')
            end

            assert_form_group do
              assert_label :age, nil, 'What is your age?'
              assert_hint :age, nil, 'This is a hint'
              assert_input :age, type: :number, value: '30',
                                 attributes: { 'aria-describedby' => 'assistant_age_hint' }
            end
          end

          test 'ds_number_field with options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_number_field(:age, class: 'geoff', placeholder: 'bar')
            end

            assert_form_group do
              assert_label :age, nil, 'What is your age?'
              assert_input :age, type: :number, value: '30',
                                 classes: ['geoff'],
                                 attributes: { placeholder: 'bar' }
            end
          end

          test 'ds_number_field with pirate locale' do
            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
                f.ds_number_field(:age)
              end

              assert_form_group do
                assert_label :age, nil, 'Age, yarr'
              end
            end
          end

          test 'ds_phone_field' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_phone_field(:phone)
            end

            assert_form_group do
              assert_label :phone, nil, 'What is your phone number?'
              assert_input :phone, type: :tel, value: '07700900001'
            end
          end

          test 'ds_phone_field with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_phone_field(:phone, hint: 'This is a hint')
            end

            assert_form_group do
              assert_label :phone, nil, 'What is your phone number?'
              assert_hint :phone, nil, 'This is a hint'
              assert_input :phone, type: :tel, value: '07700900001',
                                   attributes: { 'aria-describedby' => 'assistant_phone_hint' }
            end
          end

          test 'ds_phone_field with options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_phone_field(:phone, class: 'geoff', placeholder: 'bar', width: 20)
            end

            assert_form_group do
              assert_label :phone, nil, 'What is your phone number?'
              assert_input :phone, type: :tel, value: '07700900001',
                                   classes: ["#{@brand}-input--width-20", 'geoff'],
                                   attributes: { placeholder: 'bar' }
            end
          end

          test 'ds_phone_field with pirate locale' do
            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
                f.ds_phone_field(:phone)
              end

              assert_form_group do
                assert_label :phone, nil, 'Phone, yarr'
              end
            end
          end

          test 'ds_radio_button' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_radio_buttons_fieldset(:desired_filling) do
                f.ds_radio_button(:desired_filling, :pastrami) +
                  f.ds_radio_button(:desired_filling, :cheddar)
              end
            end

            assert_form_group do
              assert_select("fieldset.#{@brand}-fieldset") do
                legend = assert_select("legend.#{@brand}-fieldset__legend").first
                assert_equal 'What do you want in your sandwich?', legend.text.strip

                assert_select("div.#{@brand}-radios[data-module='#{@brand}-radios']") do
                  assert_select("div.#{@brand}-radios__item:nth-child(1)") do
                    input = assert_select("input.#{@brand}-radios__input").first
                    assert_equal 'assistant_desired_filling_pastrami', input['id']
                    assert_equal 'assistant[desired_filling]', input['name']
                    assert_equal 'pastrami', input['value']
                    assert_equal 'radio', input['type']

                    assert_label :desired_filling, 'pastrami', classes: ["#{@brand}-radios__label"]
                  end

                  assert_select("div.#{@brand}-radios__item:nth-child(2)") do
                    input = assert_select("input.#{@brand}-radios__input").first
                    assert_equal 'assistant_desired_filling_cheddar', input['id']
                    assert_equal 'assistant[desired_filling]', input['name']
                    assert_equal 'cheddar', input['value']
                    assert_equal 'radio', input['type']

                    assert_label :desired_filling, 'cheddar', classes: ["#{@brand}-radios__label"]
                  end
                end
              end
            end
          end

          test 'ds_radio_button with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_radio_buttons_fieldset(:desired_filling, hint: 'This is a hint') do
                f.ds_radio_button(:desired_filling, :pastrami, hint: 'Brined, smoked, steamed and seasoned') +
                  f.ds_radio_button(:desired_filling, :cheddar, hint: 'A sharp, off-white natural cheese')
              end
            end

            assert_form_group do
              assert_select("fieldset.#{@brand}-fieldset") do
                legend = assert_select("legend.#{@brand}-fieldset__legend").first
                assert_equal 'What do you want in your sandwich?', legend.text.strip

                assert_hint :desired_filling, nil, 'This is a hint'

                assert_select("div.#{@brand}-radios[data-module='#{@brand}-radios']") do
                  assert_select("div.#{@brand}-radios__item:nth-child(1)") do
                    input = assert_select("input.#{@brand}-radios__input").first
                    assert_equal 'assistant_desired_filling_pastrami', input['id']
                    assert_equal 'assistant[desired_filling]', input['name']
                    assert_equal 'pastrami', input['value']
                    assert_equal 'radio', input['type']

                    assert_label :desired_filling, 'pastrami', classes: ["#{@brand}-radios__label"]

                    assert_hint :desired_filling, 'pastrami', 'Brined, smoked, steamed and seasoned',
                                classes: ["#{@brand}-radios__hint"]
                  end

                  assert_select("div.#{@brand}-radios__item:nth-child(2)") do
                    input = assert_select("input.#{@brand}-radios__input").first
                    assert_equal 'assistant_desired_filling_cheddar', input['id']
                    assert_equal 'assistant[desired_filling]', input['name']
                    assert_equal 'cheddar', input['value']
                    assert_equal 'radio', input['type']

                    assert_label :desired_filling, 'cheddar', classes: ["#{@brand}-radios__label"]

                    assert_hint :desired_filling, 'cheddar', 'A sharp, off-white natural cheese',
                                classes: ["#{@brand}-radios__hint"]
                  end
                end
              end
            end
          end

          test 'ds_radio_buttons_fieldset with option inline' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_radio_buttons_fieldset(:desired_filling, inline: true) do
                f.ds_radio_button(:desired_filling, :pastrami) +
                  f.ds_radio_button(:desired_filling, :cheddar)
              end
            end

            assert_form_group do
              assert_select("fieldset.#{@brand}-fieldset") do
                legend = assert_select("legend.#{@brand}-fieldset__legend").first
                assert_equal 'What do you want in your sandwich?', legend.text.strip

                assert_select("div.#{@brand}-radios.#{@brand}-radios--inline[data-module='#{@brand}-radios']") do
                  assert_select("div.#{@brand}-radios__item:nth-child(1)") do
                    assert_select("input.#{@brand}-radios__input")
                    assert_select("label.#{@brand}-label.#{@brand}-radios__label", 'Pastrami')
                  end

                  assert_select("div.#{@brand}-radios__item:nth-child(2)") do
                    assert_select("input.#{@brand}-radios__input")
                    assert_select("label.#{@brand}-label.#{@brand}-radios__label", 'Cheddar')
                  end
                end
              end
            end
          end

          test 'ds_radio_buttons_fieldset with html options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_radio_buttons_fieldset(:desired_filling, class: 'geoff', 'data-foo': 'bar') do
                f.ds_radio_button(:desired_filling, :pastrami) +
                  f.ds_radio_button(:desired_filling, :cheddar)
              end
            end

            assert_form_group do
              assert_select("fieldset.#{@brand}-fieldset") do
                legend = assert_select("legend.#{@brand}-fieldset__legend").first
                assert_equal 'What do you want in your sandwich?', legend.text.strip

                assert_select("div.#{@brand}-radios.geoff[data-foo=bar][data-module='#{@brand}-radios']") do
                  assert_select("div.#{@brand}-radios__item:nth-child(1)") do
                    assert_select("input.#{@brand}-radios__input")
                    assert_select("label.#{@brand}-label.#{@brand}-radios__label", 'Pastrami')
                  end
                end
              end
            end
          end

          test 'ds_collection_radio_buttons with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_collection_radio_buttons(:department_id, Department.all, :id, :title, hint: 'This is a hint')
            end

            assert_form_group do
              assert_select("fieldset.#{@brand}-fieldset") do
                legend = assert_select("legend.#{@brand}-fieldset__legend").first
                assert_equal 'What is your department?', legend.text.strip

                assert_hint :department_id, nil, 'This is a hint'

                assert_select("div.#{@brand}-radios") do
                  radio_items = assert_select("div.#{@brand}-radios__item")
                  assert_equal 5, radio_items.length, 'Expected 3 radio items'
                end

                assert_select("div.#{@brand}-radios__item:nth-child(1)") do
                  radio_1 = assert_select("input.#{@brand}-radios__input").first
                  assert_equal 'assistant_department_id_1', radio_1['id']
                  assert_equal 'assistant[department_id]', radio_1['name']
                  assert_equal 'radio', radio_1['type']
                  assert_equal '1', radio_1['value']

                  assert_label :department_id, '1', 'Sales', classes: ["#{@brand}-radios__label"]
                end

                assert_select("div.#{@brand}-radios__item:nth-child(2)") do
                  radio_2 = assert_select("input.#{@brand}-radios__input").first
                  assert_equal 'assistant_department_id_2', radio_2['id']
                  assert_equal 'assistant[department_id]', radio_2['name']
                  assert_equal 'radio', radio_2['type']
                  assert_equal '2', radio_2['value']

                  assert_label :department_id, '2', 'Marketing', classes: ["#{@brand}-radios__label"]
                end

                assert_select("div.#{@brand}-radios__item:nth-child(3)") do
                  radio_3 = assert_select("input.#{@brand}-radios__input").first
                  assert_equal 'assistant_department_id_3', radio_3['id']
                  assert_equal 'assistant[department_id]', radio_3['name']
                  assert_equal 'radio', radio_3['type']
                  assert_equal '3', radio_3['value']

                  assert_label :department_id, '3', 'Finance', classes: ["#{@brand}-radios__label"]
                end

                assert_select("div.#{@brand}-radios__item:nth-child(4)") do
                  radio_4 = assert_select("input.#{@brand}-radios__input").first
                  assert_equal 'assistant_department_id_4', radio_4['id']
                  assert_equal 'assistant[department_id]', radio_4['name']
                  assert_equal 'radio', radio_4['type']
                  assert_equal '4', radio_4['value']

                  assert_label :department_id, '4', 'Operations', classes: ["#{@brand}-radios__label"]
                end

                assert_select("div.#{@brand}-radios__item:nth-child(5)") do
                  radio_5 = assert_select("input.#{@brand}-radios__input").first
                  assert_equal 'assistant_department_id_5', radio_5['id']
                  assert_equal 'assistant[department_id]', radio_5['name']
                  assert_equal 'radio', radio_5['type']
                  assert_equal '5', radio_5['value']

                  assert_label :department_id, '5', 'Personnel', classes: ["#{@brand}-radios__label"]
                end
              end
            end
          end

          test 'ds_collection_radio_buttons with html options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_collection_radio_buttons(:department_id, Department.all, :id, :title, {},
                                            { class: 'geoff', placeholder: 'bar' })
            end

            assert_form_group do
              assert_select("div.#{@brand}-radios.geoff[placeholder=bar]") do
                assert_select("div.#{@brand}-radios__item") do
                  radio_1 = assert_select("input.#{@brand}-radios__input").first
                  assert_equal 'assistant_department_id_1', radio_1['id']
                  assert_equal 'assistant[department_id]', radio_1['name']
                  assert_equal 'radio', radio_1['type']
                  assert_equal '1', radio_1['value']

                  assert_label :department_id, '1', 'Sales', classes: ["#{@brand}-radios__label"]
                end
              end
            end
          end

          test 'ds_collection_radio_buttons with block' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_collection_radio_buttons(:department_id, Department.all, :id, :title) do
                content_tag(:p, 'Hello')
              end
            end

            assert_form_group do
              assert_select("fieldset.#{@brand}-fieldset") do
                assert_select('p', 'Hello')
              end
            end
          end

          test 'ds_select with options (hint and label)' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_select(:department_id,
                          options_for_select(Department.all.map { |department| [department.title, department.id] }),
                          hint: 'This is a hint', label: { size: 'l' })
            end

            assert_form_group do
              assert_hint :department_id, nil, 'This is a hint'

              select = assert_select("select.#{@brand}-select").first
              assert_equal 'assistant_department_id_hint', select['aria-describedby']
              assert_select("label.#{@brand}-label.#{@brand}-label--l", text: 'What is your department?')
            end
          end

          test 'ds_select with html options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_select(:department_id, options_for_select(Department.all.map do |department|
                [department.title, department.id]
              end), {}, { class: 'geoff', placeholder: 'bar' })
            end

            assert_form_group do
              assert_label :department_id, nil, 'What is your department?'
              assert_select("select.#{@brand}-select.geoff[placeholder=bar]")
            end
          end

          test 'ds_select without choices' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_select(:department_id, { hint: 'This is a hint' }, { class: 'geoff', placeholder: 'bar' })
            end

            assert_form_group do
              assert_hint :department_id, nil, 'This is a hint'
              assert_select("select.#{@brand}-select.geoff[placeholder='bar']") do
                assert_select 'option', count: 0
              end
            end
          end

          test 'ds_select with locale' do
            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
                f.ds_select(:department_id, options_for_select(Department.all.map do |department|
                  [department.title, department.id]
                end))
              end
            end

            assert_form_group do
              assert_label :department_id, nil, 'Department, yarr'
            end
          end

          test 'ds_select with block' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_select(:department_id) do
                options_for_select(Department.all.map { |department| [department.title, department.id] })
              end
            end

            assert_form_group do
              assert_label :department_id, nil, 'What is your department?'

              select = assert_select("select.#{@brand}-select").first
              assert_equal 'assistant_department_id', select['id']
              assert_equal 'assistant[department_id]', select['name']

              options = assert_select('option')
              assert_equal '1', options[0]['value']
              assert_equal 'Sales', options[0].text.strip
              assert_equal '2', options[1]['value']
              assert_equal 'Marketing', options[1].text.strip
              assert_equal '3', options[2]['value']
              assert_equal 'Finance', options[2].text.strip
            end
          end

          test 'ds_submit' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder, &:ds_submit)

            assert_select('form') do
              button = assert_select("button.#{@brand}-button[type=submit]").first
              assert_equal 'formnovalidate', button['formnovalidate']
              assert_equal "#{@brand}-button", button['data-module']
              assert_equal 'true', button['data-prevent-double-click']
              assert_equal 'Continue', button.text.strip
            end
          end

          test 'ds_submit with secondary' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_submit('Draft', type: :secondary)
            end

            assert_select('form') do
              button = assert_select("button.#{@brand}-button.#{@brand}-button--secondary[type=submit]").first
              assert_equal 'formnovalidate', button['formnovalidate']
              assert_equal "#{@brand}-button", button['data-module']
              assert_equal 'true', button['data-prevent-double-click']
              assert_equal 'Draft', button.text.strip
            end
          end

          test 'ds_submit with warning' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_submit('Warning', type: :warning)
            end

            assert_select('form') do
              button = assert_select("button.#{@brand}-button.#{@brand}-button--warning[type=submit]").first
              assert_equal 'formnovalidate', button['formnovalidate']
              assert_equal "#{@brand}-button", button['data-module']
            end
          end

          test 'ds_submit with disabled' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_submit('Disabled', type: :secondary, disabled: true)
            end

            assert_select('form') do
              button = assert_select("button.#{@brand}-button[type=submit]").first
              assert_equal 'disabled', button['disabled']
            end
          end

          test 'ds_text_area' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_text_area(:description)
            end

            assert_form_group do
              assert_label :description, nil, 'Enter description'
              assert_text_area :description
            end
          end

          test 'ds_text_area with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_text_area(:description, hint: 'This is a hint')
            end

            assert_form_group do
              assert_label :description, nil, 'Enter description'
              assert_hint :description, nil, 'This is a hint'
              assert_text_area :description,
                               attributes: { 'aria-describedby' => 'assistant_description_hint' }
            end
          end

          test 'ds_text_area with options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_text_area(:description, class: 'geoff', placeholder: 'bar', rows: 2, max_words: 20)
            end

            assert_form_group(["#{@brand}-character-count[data-module='#{@brand}-character-count'][data-maxwords='20']"]) do
              assert_label :description, nil, 'Enter description'
              assert_text_area :description,
                               classes: ['geoff'],
                               attributes: { placeholder: 'bar', rows: 2,
                                             'aria-describedby' => 'assistant_description-info' }

              info = assert_select("span.#{@brand}-hint.#{@brand}-character-count__message").first
              assert_includes info.text.strip, '20 words'
              assert_equal 'assistant_description-info', info['id']
            end
          end

          test 'ds_text_area with pirate locale' do
            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
                f.ds_text_area(:description)
              end

              assert_form_group do
                assert_label :description, nil, 'Description, yarr'
              end
            end
          end

          test 'ds_text_field' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_text_field(:title)
            end

            assert_form_group do
              assert_label :title, nil, 'Title'
              assert_input :title, type: :text, value: 'Lorem ipsum dolor sit amet'
            end
          end

          test 'ds_text_field with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_text_field(:title, hint: 'This is a hint')
            end

            assert_form_group do
              assert_label :title, nil, 'Title'
              assert_hint :title, nil, 'This is a hint'
              assert_input :title, type: :text, value: 'Lorem ipsum dolor sit amet',
                                   attributes: { 'aria-describedby' => 'assistant_title_hint' }
            end
          end

          test 'ds_text_field with options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_text_field(:title, class: 'geoff', placeholder: 'bar')
            end

            assert_form_group do
              assert_label :title, nil, 'Title'
              assert_input :title, type: :text, value: 'Lorem ipsum dolor sit amet', classes: ['geoff'],
                                   attributes: { placeholder: 'bar' }
            end
          end

          test 'ds_text_field with pirate locale' do
            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
                f.ds_text_field(:title)
              end

              assert_form_group do
                assert_label :title, nil, 'Title, yarr'
              end
            end
          end

          test 'ds_url_field' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_url_field(:website)
            end

            assert_form_group do
              assert_label :website, nil, 'What is your website?'
              assert_input :website, type: :url, value: 'https://www.ab.com'
            end
          end

          test 'ds_url_field with hint' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_url_field(:website, hint: 'This is a hint')
            end

            assert_form_group do
              assert_label :website, nil, 'What is your website?'
              assert_hint :website, nil, 'This is a hint'
              assert_input :website, type: :url, value: 'https://www.ab.com',
                                     attributes: { 'aria-describedby' => 'assistant_website_hint' }
            end
          end

          test 'ds_url_field with options' do
            @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
              f.ds_url_field(:website, class: 'geoff', placeholder: 'bar')
            end

            assert_form_group do
              assert_label :website, nil, 'What is your website?'
              assert_input :website, type: :url, value: 'https://www.ab.com',
                                     classes: ['geoff'],
                                     attributes: { placeholder: 'bar' }
            end
          end

          test 'ds_url_field with pirate locale' do
            I18n.with_locale :pirate do
              @output_buffer = ds_form_with(model: assistants(:one), builder: @builder) do |f|
                f.ds_url_field(:website)
              end

              assert_form_group do
                assert_label :website, nil, 'Website, yarr'
              end
            end
          end

          test 'suppresses inline error when suppress_error is true' do
            @assistant = Assistant.new
            assert_not @assistant.valid?
            assert @assistant.errors[:title].any?, 'Title should have errors'

            @output_buffer = ds_form_with(model: @assistant, builder: @builder, url: '#') do |f|
              f.ds_text_field(:title, label: { text: 'Title' }, suppress_error: true)
            end

            # Assert that the inline error message is NOT present
            assert_select_from(@output_buffer, "p.#{@brand}-error-message", count: 0)
          end

          test 'shows inline error when suppress_error is false' do
            @assistant = Assistant.new
            assert_not @assistant.valid?
            assert @assistant.errors[:title].any?, 'Title should have errors'

            @output_buffer = ds_form_with(model: @assistant, builder: @builder, url: '#') do |f|
              f.govuk_text_field(:title, label: { text: 'Title' }, suppress_error: false)
            end

            # Assert that the inline error message IS present
            @assistant.errors[:title].first
            assert_select_from(@output_buffer, "p.#{@brand}-error-message", count: 1)
          end

          test 'ds_method_name and method_name should produce equivalent elements' do
            %i[text_field email_field phone_field].each do |method_name|
              ds_output = ds_form_with(model: assistants(:one)) do |f|
                f.send("ds_#{method_name}", :title)
              end

              rails_output = form_with(model: assistants(:one)) do |f|
                f.label(:title) + f.send(method_name, :title)
              end

              ds_doc = Nokogiri::HTML(ds_output)
              rails_doc = Nokogiri::HTML(rails_output)

              ds_input = ds_doc.at_css('input:not([type="hidden"])')
              rails_input = rails_doc.at_css('input:not([type="hidden"])')

              assert_equal ds_input['id'], rails_input['id']
              assert_equal ds_input['name'], rails_input['name']

              ds_label = ds_doc.at_css('label')
              rails_label = rails_doc.at_css('label')

              assert_equal ds_label.text.strip, rails_label.text.strip
            end
          end

          test 'ds_select and select should produce equivalent elements' do
            collection = Department.all.map { |d| [d.title, d.id] }

            ds_output = ds_form_with(model: assistants(:one)) do |f|
              f.ds_select(:department_id, collection)
            end

            rails_output = ds_form_with(model: assistants(:one)) do |f|
              f.label(:department_id) + f.select(:department_id, collection)
            end

            ds_doc = Nokogiri::HTML(ds_output)
            rails_doc = Nokogiri::HTML(rails_output)

            # Compare the select tags
            ds_select = ds_doc.at_css('select')
            rails_select = rails_doc.at_css('select')
            assert_equal ds_select['id'], rails_select['id']
            assert_equal ds_select['name'], rails_select['name']

            # Compare the options
            ds_options = ds_doc.css('option').map { |o| [o['value'], o.text.strip] }
            rails_options = rails_doc.css('option').map { |o| [o['value'], o.text.strip] }
            assert_equal ds_options, rails_options

            # Compare the labels
            ds_label = ds_doc.at_css('label')
            rails_label = rails_doc.at_css('label')
            assert_equal ds_label.text.strip, rails_label.text.strip
          end

          test 'ds_check_box and check_box should produce equivalent elements' do
            choices = [[:pastrami, 'Pastrami'], [:cheddar, 'Cheddar']]

            ds_output = ds_form_with(model: assistants(:one)) do |f|
              f.ds_check_boxes_fieldset(:desired_filling) do
                choices.map { |value, _text| f.ds_check_box(:desired_filling, {}, value) }.join.html_safe
              end
            end

            rails_output = ds_form_with(model: assistants(:one)) do |f|
              choices.map do |value, text|
                f.check_box(:desired_filling, { multiple: true }, value,
                            '') + f.label(:desired_filling, text, value: value)
              end.join.html_safe
            end

            ds_doc = Nokogiri::HTML(ds_output)
            rails_doc = Nokogiri::HTML(rails_output)

            # Compare the checkboxes
            ds_checkboxes = ds_doc.css('input[type=checkbox]')
            rails_checkboxes = rails_doc.css('input[type=checkbox]')

            assert_equal ds_checkboxes.size, rails_checkboxes.size

            ds_checkboxes.each_with_index do |ds_checkbox, i|
              rails_checkbox = rails_checkboxes[i]
              assert_equal ds_checkbox['id'], rails_checkbox['id']
              assert_equal ds_checkbox['name'], rails_checkbox['name']
              assert_equal ds_checkbox['value'], rails_checkbox['value']
            end

            # Compare the labels
            ds_labels = ds_doc.css('label')
            rails_labels = rails_doc.css('label')

            assert_equal ds_labels.size, rails_labels.size

            ds_labels.each_with_index do |ds_label, i|
              rails_label = rails_labels[i]
              assert_equal ds_label['for'], rails_label['for']
              # We have stopped default humanize behaviour in DS labels for options in checkbox
              assert_equal ds_label.text.humanize.strip, rails_label.text.strip
            end
          end

          test 'ds_radio_button and radio_button should produce equivalent elements' do
            choices = [[:pastrami, 'Pastrami'], [:cheddar, 'Cheddar']]

            ds_output = ds_form_with(model: assistants(:one)) do |f|
              f.ds_radio_buttons_fieldset(:desired_filling) do
                choices.map { |value, _text| f.ds_radio_button(:desired_filling, value, {}) }.join.html_safe
              end
            end

            rails_output = ds_form_with(model: assistants(:one)) do |f|
              choices.map do |value, text|
                f.radio_button(:desired_filling, value) + f.label(:desired_filling, text, value: value)
              end.join.html_safe
            end

            ds_doc = Nokogiri::HTML(ds_output)
            rails_doc = Nokogiri::HTML(rails_output)

            # Compare the radio buttons
            ds_radios = ds_doc.css('input[type=radio]')
            rails_radios = rails_doc.css('input[type=radio]')

            assert_equal ds_radios.size, rails_radios.size, 'Should have the same number of radio buttons'

            ds_radios.each_with_index do |ds_radio, i|
              rails_radio = rails_radios[i]
              assert_equal ds_radio['id'], rails_radio['id']
              assert_equal ds_radio['name'], rails_radio['name']
              assert_equal ds_radio['value'], rails_radio['value']
            end

            # Compare the labels
            ds_labels = ds_doc.css('label')
            rails_labels = rails_doc.css('label')

            assert_equal ds_labels.size, rails_labels.size, 'Should have the same number of labels'

            ds_labels.each_with_index do |ds_label, i|
              rails_label = rails_labels[i]
              assert_equal ds_label['for'], rails_label['for']
              assert_equal ds_label.text.strip, rails_label.text.strip
            end
          end

          private

          # Helper to use assert_select on a string of HTML output
          def assert_select_from(html_output, ...)
            parsed_html = Nokogiri::HTML::DocumentFragment.parse(html_output)
            assert_select(parsed_html, ...)
          end
        end
      end
    end
  end
end
