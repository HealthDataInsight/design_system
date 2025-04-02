require 'design_system/registry'

# This concern manages choosing the relevant layout for our given design system
module GovukFormBuilderTestable
  include GovukFormBuilderTestableHelper
  extend ActiveSupport::Concern

  included do
    test 'self.brand' do
      assert_equal @brand, @builder.brand
    end

    test 'ds_check_box with single checkbox' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_check_boxes_fieldset(:desired_filling, { multiple: true }) do
          f.ds_check_box(:desired_filling, { multiple: true }, :pastrami)
        end
      end

      assert_form_group do
        assert_select("fieldset.#{@brand}-fieldset") do
          assert_select("legend.#{@brand}-fieldset__legend.#{@brand}-fieldset__legend--m", 'What do you want in your sandwich?')

          input = assert_select('input').first
          assert_equal 'assistant_desired_filling', input['id']
          assert_equal 'assistant[desired_filling][]', input['name']
          assert_equal '', input['value']
          assert_equal 'hidden', input['type']
          assert_equal 'off', input['autocomplete']

          assert_select("div.#{@brand}-checkboxes[data-module='#{@brand}-checkboxes']") do
            assert_select("div.#{@brand}-checkboxes__item") do
              input = assert_select("input.#{@brand}-checkboxes__input").first
              assert_equal 'assistant-desired-filling-pastrami-field', input['id']
              assert_equal 'assistant[desired_filling][]', input['name']
              assert_equal 'pastrami', input['value']
              assert_equal 'checkbox', input['type']

              label = assert_select("label.#{@brand}-label.#{@brand}-checkboxes__label[for='assistant-desired-filling-pastrami-field']").first
              assert_equal 'Pastrami', label.text.strip
            end
          end
        end
      end
    end

    test 'ds_collection_select' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title)
      end

      assert_form_group do
        assert_label :department_id, "What's your department?"

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant-department-id-field', select['id']
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
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :department_id, "What's your department?"
        assert_hint :department_id, 'This is a hint'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant-department-id-hint', select['aria-describedby']
      end
    end

    test 'ds_collection_select with html options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, { hint: 'This is a hint' }, { class: 'geoff', placeholder: 'bar' })
      end

      assert_form_group do
        assert_label :department_id, "What's your department?"

        select = assert_select("select.#{@brand}-select.geoff[placeholder=bar]").first
        assert_equal 'assistant-department-id-field', select['id']
        assert_equal 'assistant[department_id]', select['name']

        options = assert_select('option')
        assert_equal '1', options[0]['value']
        assert_equal 'Sales', options[0].text.strip
      end
    end

    test 'ds_date_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_date_field(:date_of_birth, hint: 'This is a hint', legend: 'Date of birth')
      end

      assert_form_group do
        assert_select("fieldset.#{@brand}-fieldset[aria-describedby=assistant-date-of-birth-hint]") do
          legend = assert_select("legend.#{@brand}-fieldset__legend").first
          assert_equal 'Date of birth', legend.text.strip

          assert_hint :date_of_birth, 'This is a hint'

          date_input = assert_select("div.#{@brand}-date-input").first
          assert date_input, 'Date input container not found'

          # Test day input
          day_item = assert_select("div.#{@brand}-date-input__item:nth-child(1)")
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
          month_item = assert_select("div.#{@brand}-date-input__item:nth-child(2)")
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
          year_item = assert_select("div.#{@brand}-date-input__item:nth-child(3)")
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

    test 'ds_email_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email)
      end

      assert_form_group do
        assert_label :email, "What's your email?"
        assert_input :email, type: :email, value: 'ab@example.com'
      end
    end

    test 'ds_email_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :email, "What's your email?"
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
        assert_label :email, "What's your email?"
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

    # NOTE: We test the file field without ActiveStorage to keep the design system lightweight.
    # We only test the HTML structure and attributes, not the actual file handling functionality.
    test 'ds_file_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_file_field(:cv)
      end

      assert_form_group do
        assert_label :cv, 'Upload a file'
        assert_file_upload :cv, type: :file
      end
    end

    test 'ds_file_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_file_field(:cv, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :cv, 'Upload a file'
        assert_hint :cv, 'This is a hint'
        assert_file_upload :cv, type: :file, attributes: { 'aria-describedby' => 'assistant-cv-hint' }
      end
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

    test 'ds_number_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_number_field(:age)
      end

      assert_form_group do
        assert_label :age, "What's your age?"
        assert_input :age, type: :number, value: '30'
      end
    end

    test 'ds_number_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_number_field(:age, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :age, "What's your age?"
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
        assert_label :age, "What's your age?"
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

    test 'ds_phone_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone)
      end

      assert_form_group do
        assert_label :phone, "What's your phone number?"
        assert_input :phone, type: :tel, value: '07700900001'
      end
    end

    test 'ds_phone_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :phone, "What's your phone number?"
        assert_hint :phone, 'This is a hint'
        assert_input :phone, type: :tel, value: '07700900001', attributes: { 'aria-describedby' => 'assistant-phone-hint' }
      end
    end

    test 'ds_phone_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone, class: 'geoff', placeholder: 'bar', width: 20)
      end

      assert_form_group do
        assert_label :phone, "What's your phone number?"
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

    # test 'ds_collection_radio_buttons with legend and hint' do
    #   @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
    #     f.ds_collection_radio_buttons(:department_id, Department.all, :id, :title, legend: 'What is your department?', hint: 'This is a hint')
    #   end

    #   assert_form_group do
    #     assert_legend 'What is your department?'
    #     assert_hint :department_id, 'This is a hint'
    #     assert_select("div.#{@brand}-radios") do
    #       radio_items = assert_select("div.#{@brand}-radios__item")
    #       assert_equal 3, radio_items.length, "Expected 3 radio items"

    #       # First radio button
    #       assert_select("div.#{@brand}-radios__item:nth-child(1)") do
    #         assert_radio_input :department_id, type: :radio, value: '1', classes: ["#{@brand}-radios__input"]
    #         assert_radio_label :department_id, '1', 'Sales', classes: ["#{@brand}-radios__label"]
    #       end

    #       # Second radio button
    #       assert_select("div.#{@brand}-radios__item:nth-child(2)") do
    #         assert_radio_input :department_id, type: :radio, value: '2', classes: ["#{@brand}-radios__input"]
    #         assert_radio_label :department_id, '2', 'Marketing', classes: ["#{@brand}-radios__label"]
    #       end

    #       # Third radio button
    #       assert_select("div.#{@brand}-radios__item:nth-child(3)") do
    #         assert_radio_input :department_id, type: :radio, value: '3', classes: ["#{@brand}-radios__input"]
    #         assert_radio_label :department_id, '3', 'Finance', classes: ["#{@brand}-radios__label"]
    #       end
    #     end
    #   end
    # end

    # test 'ds_collection_radio_buttons with options' do
    #   @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
    #     f.ds_collection_radio_buttons(:department_id, Department.all, :id, :title, class: 'geoff', placeholder: 'bar')
    #   end

    #   assert_form_group do
    #     assert_select("div.#{@brand}-radios.geoff[placeholder=bar]") do
    #       assert_select("div.#{@brand}-radios__item") do
    #         assert_radio_input :department_id, type: :radio, value: '1', classes: ["#{@brand}-radios__input"]
    #         assert_radio_label :department_id, '1', 'Sales', classes: ["#{@brand}-radios__label"]
    #       end
    #     end
    #   end
    # end

    test 'ds_select with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id,
                    options_for_select(Department.all.map { |department| [department.title, department.id] }),
                    { hint: 'This is a hint' })
      end

      assert_form_group do
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

    test 'ds_select with block' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id) do
          options_for_select(Department.all.map { |department| [department.title, department.id] })
        end
      end

      assert_form_group do
        assert_label :department_id, "What's your department?"

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant-department-id-field', select['id']
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
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_submit
      end

      assert_select('form') do
        button = assert_select("button.#{@brand}-button[type=submit]").first
        assert_equal 'formnovalidate', button['formnovalidate']
        assert_equal "#{@brand}-button", button['data-module']
        assert_equal 'true', button['data-prevent-double-click']
        assert_equal 'Continue', button.text.strip
      end
    end

    test 'ds_submit with secondary' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_submit('Draft', secondary: true)
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
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_submit('Warning', warning: true)
      end

      assert_select('form') do
        button = assert_select("button.#{@brand}-button.#{@brand}-button--warning[type=submit]").first
        assert_equal 'formnovalidate', button['formnovalidate']
        assert_equal "#{@brand}-button", button['data-module']
      end
    end

    test 'ds_submit with disabled' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_submit('Disabled', disabled: true)
      end

      assert_select('form') do
        button = assert_select("button.#{@brand}-button[type=submit]").first
        assert_equal 'disabled', button['disabled']
      end
    end

    test 'ds_submit with block' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_submit do
          link_to 'Cancel', '#assistants'
        end
      end

      assert_select('form') do
        button = assert_select("button.#{@brand}-button[type=submit]").first
        assert_equal 'Continue', button.text.strip
        assert_select("a[href='#assistants']")
      end
    end

    test 'ds_text_area' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description)
      end

      assert_form_group do
        assert_label :description, 'Enter description'
        assert_text_area :description
      end
    end

    test 'ds_text_area with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :description, 'Enter description'
        assert_hint :description, 'This is a hint'
        assert_text_area :description,
                         attributes: { 'aria-describedby' => 'assistant-description-hint' }
      end
    end

    test 'ds_text_area with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description, class: 'geoff', placeholder: 'bar', rows: 2, max_words: 20)
      end

      assert_form_group(["#{@brand}-character-count[data-module='#{@brand}-character-count'][data-maxwords='20']"]) do
        assert_label :description, 'Enter description'
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

    test 'ds_url_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_url_field(:website)
      end

      assert_form_group do
        assert_label :website, "What's your website?"
        assert_input :website, type: :url, value: 'https://www.ab.com'
      end
    end

    test 'ds_url_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_url_field(:website, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :website, "What's your website?"
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
        assert_label :website, "What's your website?"
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
  end
end
