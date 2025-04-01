require 'design_system/registry'

# This concern manages choosing the relevant layout for our given design system
module GovukFormBuilderTestable
  include GovukFormBuilderTestableHelper
  extend ActiveSupport::Concern

  included do
    test 'self.brand' do
      assert_equal @brand, @builder.brand
    end

    test 'ds_label' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_label(:title)
      end

      assert_select('form') do
        assert_label :title, 'Title'
      end
    end

    test 'ds_label with content and options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_label(:title, 'Titlezzz', class: 'bob', 'data-foo': 'bar')
      end

      assert_select('form') do
        assert_select("label.#{@brand}-label[data-foo=bar]", 'Titlezzz')
      end
    end

    test 'ds_label with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_label(:title)
        end

        assert_select('form') do
          assert_label :title, 'Title, yarr'
        end
      end
    end

    test 'ds_text_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title)
      end

      assert_form_group do
        assert_label :title, 'Title'
        assert_input :title, type: :text, value: 'AB'
      end
    end

    test 'ds_text_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, hint: 'This is a hint')
      end

      assert_form_group do 
        assert_label :title, 'Title'
        assert_hint :title, 'This is a hint'
        assert_input :title, type: :text, value: 'AB', attributes: { 'aria-describedby' => 'assistant-title-hint' }
      end
    end

    test 'ds_text_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, class: 'geoff', placeholder: 'bar')
      end

      assert_form_group do
        assert_label :title, 'Title'
        assert_input :title, type: :text, value: 'AB', classes: ['geoff'], attributes: { placeholder: 'bar' }
      end
    end

    test 'ds_text_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_text_field(:title)
        end

        assert_form_group do
          assert_label :title, 'Title, yarr'
        end
      end
    end

    test 'ds_phone_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone)
      end

      assert_form_group do
        assert_label :phone, 'Phone'
        assert_input :phone, type: :tel, value: '07700900001'
      end
    end

    test 'ds_phone_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :phone, 'Phone'
        assert_hint :phone, 'This is a hint'
        assert_input :phone, type: :tel, value: '07700900001', attributes: { 'aria-describedby' => 'assistant-phone-hint' }
      end
    end

    test 'ds_phone_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone, class: 'geoff', placeholder: 'bar', width: 20)
      end

      assert_form_group do
        assert_label :phone, 'Phone'
        assert_input :phone, type: :tel, value: '07700900001', 
          classes: ["#{@brand}-input--width-20", 'geoff'], 
          attributes: { placeholder: 'bar' }
      end
    end

    test 'ds_phone_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_phone_field(:phone)
        end

        assert_form_group do
          assert_label :phone, 'Phone, yarr'
        end
      end
    end

    test 'ds_email_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email)
      end

      assert_form_group do
        assert_label :email, 'Email'
        assert_input :email, type: :email, value: 'ab@example.com'
      end
    end

    test 'ds_email_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :email, 'Email'
        assert_hint :email, 'This is a hint'
        assert_input :email, type: :email, value: 'ab@example.com', 
          attributes: { 'aria-describedby' => 'assistant-email-hint' }
      end
    end

    test 'ds_email_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email, class: 'geoff', placeholder: 'bar')
      end

      assert_form_group do
        assert_label :email, 'Email'
        assert_input :email, type: :email, value: 'ab@example.com', 
          classes: ['geoff'], 
          attributes: { placeholder: 'bar' }
      end
    end

    test 'ds_email_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_email_field(:email)
        end

        assert_form_group do
          assert_label :email, 'Email, yarr'
        end
      end
    end

    test 'ds_url_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_url_field(:website)
      end

      assert_form_group do
        assert_label :website, 'Website'
        assert_input :website, type: :url, value: 'https://www.ab.com'
      end
    end

    test 'ds_url_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_url_field(:website, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :website, 'Website'
        assert_hint :website, 'This is a hint'
        assert_input :website, type: :url, value: 'https://www.ab.com', 
          attributes: { 'aria-describedby' => 'assistant-website-hint' }
      end
    end

    test 'ds_url_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_url_field(:website, class: 'geoff', placeholder: 'bar')
      end

      assert_form_group do
        assert_label :website, 'Website'
        assert_input :website, type: :url, value: 'https://www.ab.com', 
          classes: ['geoff'], 
          attributes: { placeholder: 'bar' }
      end
    end

    test 'ds_url_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_url_field(:website)
        end

        assert_form_group do
          assert_label :website, 'Website, yarr'
        end
      end
    end

    test 'ds_number_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_number_field(:age)
      end

      assert_form_group do
        assert_label :age, 'Age'
        assert_input :age, type: :number, value: '30'
      end
    end

    test 'ds_number_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_number_field(:age, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :age, 'Age'
        assert_hint :age, 'This is a hint'
        assert_input :age, type: :number, value: '30', 
          attributes: { 'aria-describedby' => 'assistant-age-hint' }
      end
    end

    test 'ds_number_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_number_field(:age, class: 'geoff', placeholder: 'bar')
      end

      assert_form_group do
        assert_label :age, 'Age'
        assert_input :age, type: :number, value: '30', 
          classes: ['geoff'], 
          attributes: { placeholder: 'bar' }
      end
    end

    test 'ds_number_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_number_field(:age)
        end

        assert_form_group do
          assert_label :age, 'Age, yarr'
        end
      end
    end

    test 'ds_password_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title)
      end

      assert_form_group(["#{@brand}-password-input"]) do
        assert_label :title, 'Title'
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
          assert_equal 'assistant-title-field', button['aria-controls']
          assert_equal 'Show password', button['aria-label']
          assert_equal 'hidden', button['hidden']
        end
      end
    end

    test 'ds_password_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title, hint: 'This is a hint')
      end

      assert_form_group(["#{@brand}-password-input"]) do
        assert_label :title, 'Title'
        assert_hint :title, 'This is a hint'

        assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
          input = assert_select('input[type=password]').first
          assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input", input['class']
          assert_equal 'false', input['spellcheck']
          assert_equal 'current-password', input['autocomplete']
          assert_equal 'none', input['autocapitalize']
          assert_nil input['value']
          assert_equal 'assistant-title-hint', input['aria-describedby']

          button = assert_select('button[type=button]').first
          assert_equal "#{@brand}-button", button['data-module']
          assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
                        button['class']
          assert_equal 'assistant-title-field', button['aria-controls']
          assert_equal 'Show password', button['aria-label']
          assert_equal 'hidden', button['hidden']
        end
      end
    end

    test 'ds_password_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title, class: 'geoff', placeholder: 'bar')
      end

      assert_form_group(["#{@brand}-password-input"]) do
        assert_label :title, 'Title'

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
          assert_equal 'assistant-title-field', button['aria-controls']
          assert_equal 'Show password', button['aria-label']
          assert_equal 'hidden', button['hidden']
        end
      end
    end

    test 'ds_password_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_password_field(:title)
        end

        assert_form_group(["#{@brand}-password-input"]) do
          assert_label :title, 'Title, yarr'

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
            assert_equal 'assistant-title-field', button['aria-controls']
            assert_equal 'Show password', button['aria-label']
            assert_equal 'hidden', button['hidden']
          end
        end
      end
    end

    test 'ds_text_area' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description)
      end

      assert_form_group do
        assert_label :description, 'Description'
        assert_text_area :description
      end
    end

    test 'ds_text_area with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :description, 'Description'
        assert_hint :description, 'This is a hint'
        assert_text_area :description, 
          attributes: { 'aria-describedby' => 'assistant-description-hint' }
      end
    end

    test 'ds_text_area with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description, class: 'geoff', placeholder: 'bar', rows: 2, max_words: 20)
      end

      assert_form_group(["#{@brand}-character-count[data-module='govuk-character-count'][data-maxwords='20']"]) do
        assert_label :description, 'Description'
        assert_text_area :description, 
          classes: ['geoff'], 
          attributes: { placeholder: 'bar', rows: 2, 'aria-describedby' => 'assistant-description-field-info' }

        info = assert_select("span.#{@brand}-hint.#{@brand}-character-count__message").first
        assert_includes info.text.strip, '20 words'
        assert_equal 'assistant-description-field-info', info['id']
      end
    end

    test 'ds_text_area with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_text_area(:description)
        end

        assert_form_group do
          assert_label :description, 'Description, yarr'
        end
      end
    end

    test 'ds_collection_select' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title)
      end

      assert_form_group do
        assert_label :department_id, 'Department'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant-department-id-field', select['id']
        assert_equal 'assistant[department_id]', select['name']

        options = assert_select("option")
        assert_equal '1', options[0]['value']
        assert_equal 'Sales', options[0].text.strip
        assert_equal '2', options[1]['value']
        assert_equal 'Marketing', options[1].text.strip
        assert_equal '3', options[2]['value']
        assert_equal 'Finance', options[2].text.strip
      end
    end

    test 'ds_collection_select with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :department_id, 'Department'
        assert_hint :department_id, 'This is a hint'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant-department-id-hint', select['aria-describedby']
      end
    end

    test 'ds_collection_select with html options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, hint: 'This is a hint', class: 'geoff', placeholder: 'bar')
      end

      assert_form_group do
        assert_label :department_id, 'Department'

        select = assert_select("select.#{@brand}-select.geoff[placeholder=bar]").first
        assert_equal 'assistant-department-id-field', select['id']
        assert_equal 'assistant[department_id]', select['name']

        options = assert_select("option")
        assert_equal '1', options[0]['value']
        assert_equal 'Sales', options[0].text.strip
      end
    end

    test 'ds_select with block' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id) do
          options_for_select(Department.all.map { |department| [department.title, department.id] })
        end
      end

      assert_form_group do
        assert_label :department_id, 'Department'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant-department-id-field', select['id']
        assert_equal 'assistant[department_id]', select['name']

        options = assert_select("option")
        assert_equal '1', options[0]['value']
        assert_equal 'Sales', options[0].text.strip
        assert_equal '2', options[1]['value']
        assert_equal 'Marketing', options[1].text.strip
        assert_equal '3', options[2]['value']
        assert_equal 'Finance', options[2].text.strip
      end
    end

    test 'ds_select with label and hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id, options_for_select(Department.all.map { |department| [department.title, department.id] }), label: 'Department label', hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :department_id, 'Department label'
        assert_hint :department_id, 'This is a hint'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant-department-id-hint', select['aria-describedby']
      end
    end

    test 'ds_select with locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_select(:department_id, options_for_select(Department.all.map { |department| [department.title, department.id] }))
        end
      end

      assert_form_group do
        assert_label :department_id, 'Department, yarr'
      end
    end

    test 'ds_collection_radio_buttons with legend and hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_radio_buttons(:department_id, Department.all, :id, :title, legend: 'What is your department?', hint: 'This is a hint')
      end

      assert_form_group do
        assert_legend 'What is your department?'
        assert_hint :department_id, 'This is a hint'
        assert_select("div.#{@brand}-radios") do
          radio_items = assert_select("div.#{@brand}-radios__item")
          assert_equal 3, radio_items.length, "Expected 3 radio items"

          # First radio button
          assert_select("div.#{@brand}-radios__item:nth-child(1)") do
            assert_radio_input :department_id, type: :radio, value: '1', classes: ["#{@brand}-radios__input"]
            assert_radio_label :department_id, '1', 'Sales', classes: ["#{@brand}-radios__label"]
          end

          # Second radio button
          assert_select("div.#{@brand}-radios__item:nth-child(2)") do
            assert_radio_input :department_id, type: :radio, value: '2', classes: ["#{@brand}-radios__input"]
            assert_radio_label :department_id, '2', 'Marketing', classes: ["#{@brand}-radios__label"]
          end

          # Third radio button
          assert_select("div.#{@brand}-radios__item:nth-child(3)") do
            assert_radio_input :department_id, type: :radio, value: '3', classes: ["#{@brand}-radios__input"]
            assert_radio_label :department_id, '3', 'Finance', classes: ["#{@brand}-radios__label"]
          end
        end
      end
    end

    test 'ds_collection_radio_buttons with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_radio_buttons(:department_id, Department.all, :id, :title, class: 'geoff', placeholder: 'bar')
      end
      
      assert_form_group do
        assert_select("div.#{@brand}-radios.geoff[placeholder=bar]") do
          assert_select("div.#{@brand}-radios__item") do
            assert_radio_input :department_id, type: :radio, value: '1', classes: ["#{@brand}-radios__input"]
            assert_radio_label :department_id, '1', 'Sales', classes: ["#{@brand}-radios__label"]
          end
        end
      end
    end
  end
end
