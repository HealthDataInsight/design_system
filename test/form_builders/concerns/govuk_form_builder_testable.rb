require 'design_system/registry'

# This concern manages choosing the relevant layout for our given design system
module GovukFormBuilderTestable
  include GovukFormBuilderTestableHelper
  extend ActiveSupport::Concern

  included do
    test 'self.brand' do
      assert_equal @brand, @builder.brand
    end

    test 'ds_collection_select' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title)
      end

      assert_form_group do
        assert_label :department_id, "What's your department?"

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
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :department_id, "What's your department?"
        assert_hint :department_id, 'This is a hint'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant_department_id_hint', select['aria-describedby']
      end
    end

    test 'ds_collection_select with html options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, {}, { class: 'geoff', placeholder: 'bar' })
      end

      assert_form_group do
        assert_label :department_id, "What's your department?"

        select = assert_select("select.#{@brand}-select.geoff[placeholder=bar]").first
        assert_equal 'assistant_department_id', select['id']
        assert_equal 'assistant[department_id]', select['name']

        options = assert_select('option')
        assert_equal '1', options[0]['value']
        assert_equal 'Sales', options[0].text.strip
      end
    end

    test 'ds_collection_select with custom label size' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, label: { size: 'l' })
      end

      assert_form_group do
        assert_select("label.#{@brand}-label.#{@brand}-label--l", text: "What's your department?")
      end
    end

    test 'ds_date_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_date_field(:date_of_birth, hint: 'This is a hint')
      end

      assert_form_group do
        assert_select("fieldset.#{@brand}-fieldset[aria-describedby=assistant_date_of_birth_hint]") do
          legend = assert_select("legend.#{@brand}-fieldset__legend").first
          assert_equal "What's your date of birth?", legend.text.strip

          assert_hint :date_of_birth, 'This is a hint'

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
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_date_field(:date_of_birth, legend: { size: nil })
      end

      assert_form_group do
        assert_select("legend.#{@brand}-fieldset__legend", text: "What's your date of birth?")
      end
    end

    test 'ds_email_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email)
      end

      assert_form_group do
        assert_label :email, "What's your email?"
        assert_input :email, type: :email, value: 'one@ex.com'
      end
    end

    test 'ds_email_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :email, "What's your email?"
        assert_hint :email, 'This is a hint'
        assert_input :email, type: :email, value: 'one@ex.com',
                             attributes: { 'aria-describedby' => 'assistant_email_hint' }
      end
    end

    test 'ds_email_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email, class: 'geoff', placeholder: 'bar')
      end

      assert_form_group do
        assert_label :email, "What's your email?"
        assert_input :email, type: :email, value: 'one@ex.com',
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

    test 'ds_error_summary' do
      assistant = Assistant.new(
        title: '',
        department_id: nil,
        password: assistants(:one).password,
        date_of_birth: assistants(:one).date_of_birth,
        phone: assistants(:one).phone
      )
      assistant.valid?

      @output_buffer = form_with(model: assistant, builder: @builder) do |f|
        f.ds_error_summary
      end

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

      @output_buffer = form_with(model: assistant, builder: @builder) do |f|
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

      @output_buffer = form_with(model: assistant, builder: @builder) do |f|
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

      @output_buffer = form_with(model: assistant, builder: @builder) do |f|
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
        @output_buffer = form_with(model: assistant, builder: @builder) do |f|
          f.ds_error_summary
        end

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
        assert_file_upload :cv, type: :file, attributes: { 'aria-describedby' => 'assistant_cv_hint' }
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
                           attributes: { 'aria-describedby' => 'assistant_age_hint' }
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
        assert_input :phone, type: :tel, value: '07700900001', attributes: { 'aria-describedby' => 'assistant_phone_hint' }
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

    test 'ds_select with options (hint and label)' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id,
                    options_for_select(Department.all.map { |department| [department.title, department.id] }),
                    hint: 'This is a hint', label: { size: 'l' })
      end

      assert_form_group do
        assert_hint :department_id, 'This is a hint'

        select = assert_select("select.#{@brand}-select").first
        assert_equal 'assistant-department-id-hint', select['aria-describedby']
        assert_select("label.#{@brand}-label.#{@brand}-label--l", text: "What's your department?")
      end
    end

    test 'ds_select with html options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id, options_for_select(Department.all.map { |department| [department.title, department.id] }), {}, { class: 'geoff', placeholder: 'bar' })
      end

      assert_form_group do
        assert_label :department_id, "What's your department?"
        assert_select("select.#{@brand}-select.geoff[placeholder=bar]")
      end
    end

    test 'ds_select without choices' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id, { hint: 'This is a hint' }, { class: 'geoff', placeholder: 'bar' })
      end

      assert_form_group do
        assert_hint :department_id, 'This is a hint'
        assert_select("select.#{@brand}-select.geoff[placeholder='bar']") do
          assert_select 'option', count: 0
        end
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
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_submit('Warning', type: :warning)
      end

      assert_select('form') do
        button = assert_select("button.#{@brand}-button.#{@brand}-button--warning[type=submit]").first
        assert_equal 'formnovalidate', button['formnovalidate']
        assert_equal "#{@brand}-button", button['data-module']
      end
    end

    test 'ds_submit with disabled' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_submit('Disabled', type: :secondary, disabled: true)
      end

      assert_select('form') do
        button = assert_select("button.#{@brand}-button[type=submit]").first
        assert_equal 'disabled', button['disabled']
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
                         attributes: { 'aria-describedby' => 'assistant_description_hint' }
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
                         attributes: { placeholder: 'bar', rows: 2, 'aria-describedby' => 'assistant_description-info' }

        info = assert_select("span.#{@brand}-hint.#{@brand}-character-count__message").first
        assert_includes info.text.strip, '20 words'
        assert_equal 'assistant_description-info', info['id']
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
        assert_input :title, type: :text, value: 'Lorem ipsum dolor sit amet'
      end
    end

    test 'ds_text_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, hint: 'This is a hint')
      end

      assert_form_group do
        assert_label :title, 'Title'
        assert_hint :title, 'This is a hint'
        assert_input :title, type: :text, value: 'Lorem ipsum dolor sit amet', attributes: { 'aria-describedby' => 'assistant_title_hint' }
      end
    end

    test 'ds_text_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, class: 'geoff', placeholder: 'bar')
      end

      assert_form_group do
        assert_label :title, 'Title'
        assert_input :title, type: :text, value: 'Lorem ipsum dolor sit amet', classes: ['geoff'], attributes: { placeholder: 'bar' }
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
                               attributes: { 'aria-describedby' => 'assistant_website_hint' }
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
