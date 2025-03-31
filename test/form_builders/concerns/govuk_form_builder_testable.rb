require 'design_system/registry'

# This concern manages choosing the relevant layout for our given design system
module GovukFormBuilderTestable
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
        assert_select("label.#{@brand}-label", 'Title')
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
          assert_select("label.#{@brand}-label", 'Title, yarr')
        end
      end
    end

    test 'ds_text_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-title-field']", 'Title')

          input = assert_select("input.#{@brand}-input[type=text]").first
          assert_equal 'assistant-title-field', input['id']
          assert_equal 'AB', input['value']
        end
      end
    end

    test 'ds_text_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-title-field']", 'Title')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-title-hint', hint['id']

          input = assert_select("input.#{@brand}-input[type=text]").first
          assert_equal 'assistant-title-field', input['id']
          assert_equal 'AB', input['value']
          assert_equal 'assistant-title-hint', input['aria-describedby']
        end
      end
    end

    test 'ds_text_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, class: 'geoff', placeholder: 'bar')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-title-field']", 'Title')

          input = assert_select("input.#{@brand}-input.geoff[type=text][placeholder=bar]").first
          assert_equal 'assistant-title-field', input['id']
          assert_equal 'AB', input['value']
        end
      end
    end

    test 'ds_text_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_text_field(:title)
        end

        assert_select('form') do
          assert_select("div.#{@brand}-form-group") do
            assert_select("label.#{@brand}-label[for='assistant-title-field']", 'Title, yarr')
          end
        end
      end
    end

    test 'ds_phone_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-phone-field']", 'Phone')

          input = assert_select("input.#{@brand}-input[type=tel]").first
          assert_equal 'assistant-phone-field', input['id']
          assert_equal '07700900001', input['value']
        end
      end
    end

    test 'ds_phone_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-phone-field']", 'Phone')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-phone-hint', hint['id']

          input = assert_select("input.#{@brand}-input[type=tel]").first
          assert_equal 'assistant-phone-hint', input['aria-describedby']
        end
      end
    end

    test 'ds_phone_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_phone_field(:phone, class: 'geoff', placeholder: 'bar', width: 20)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-phone-field']", 'Phone')

          input = assert_select("input.#{@brand}-input.#{@brand}-input--width-20.geoff[type=tel][placeholder=bar]").first
          assert_equal 'assistant-phone-field', input['id']
          assert_equal '07700900001', input['value']
        end
      end
    end

    test 'ds_phone_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_phone_field(:phone)
        end

        assert_select('form') do
          assert_select("div.#{@brand}-form-group") do
            assert_select("label.#{@brand}-label[for='assistant-phone-field']", 'Phone, yarr')
          end
        end
      end
    end

    test 'ds_email_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-email-field']", 'Email')

          input = assert_select("input.#{@brand}-input[type=email]").first
          assert_equal 'ab@example.com', input['value']
          assert_equal 'assistant-email-field', input['id']
        end
      end
    end

    test 'ds_email_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-email-field']", 'Email')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-email-hint', hint['id']

          input = assert_select("input.#{@brand}-input[type=email]").first
          assert_equal 'assistant-email-hint', input['aria-describedby']
        end
      end
    end

    test 'ds_email_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_email_field(:email, class: 'geoff', placeholder: 'bar')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-email-field']", 'Email')

          input = assert_select("input.#{@brand}-input.geoff[type=email][placeholder=bar]").first
          assert_equal 'assistant-email-field', input['id']
          assert_equal 'ab@example.com', input['value']
        end
      end
    end

    test 'ds_email_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_email_field(:email)
        end

        assert_select('form') do
          assert_select("div.#{@brand}-form-group") do
            assert_select("label.#{@brand}-label[for='assistant-email-field']", 'Email, yarr')
          end
        end
      end
    end

    test 'ds_url_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_url_field(:website)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-website-field']", 'Website')

          input = assert_select("input.#{@brand}-input[type=url]").first
          assert_equal 'https://www.ab.com', input['value']
          assert_equal 'assistant-website-field', input['id']
        end
      end
    end

    test 'ds_url_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_url_field(:website, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-website-field']", 'Website')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-website-hint', hint['id']

          input = assert_select("input.#{@brand}-input[type=url]").first
          assert_equal 'assistant-website-hint', input['aria-describedby']
        end
      end
    end

    test 'ds_url_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_url_field(:website, class: 'geoff', placeholder: 'bar')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-website-field']", 'Website')

          input = assert_select("input.#{@brand}-input.geoff[type=url][placeholder=bar]").first
          assert_equal 'https://www.ab.com', input['value']
          assert_equal 'assistant-website-field', input['id']
        end
      end
    end

    test 'ds_url_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_url_field(:website)
        end

        assert_select('form') do
          assert_select("div.#{@brand}-form-group") do
            assert_select("label.#{@brand}-label[for='assistant-website-field']", 'Website, yarr')
          end
        end
      end
    end

    test 'ds_number_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_number_field(:age)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-age-field']", 'Age')

          input = assert_select("input.#{@brand}-input[type=number]").first
          assert_equal 30, input['value'].to_i
          assert_equal 'assistant-age-field', input['id']
        end
      end
    end

    test 'ds_number_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_number_field(:age, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-age-field']", 'Age')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-age-hint', hint['id']

          input = assert_select("input.#{@brand}-input[type=number]").first
          assert_equal 'assistant-age-hint', input['aria-describedby']
        end
      end
    end

    test 'ds_number_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_number_field(:age, class: 'geoff', placeholder: 'bar')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-age-field']", 'Age')

          input = assert_select("input.#{@brand}-input.geoff[type=number][placeholder=bar]").first
          assert_equal 'assistant-age-field', input['id']
          assert_equal 30, input['value'].to_i
        end
      end
    end

    test 'ds_number_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_number_field(:age)
        end

        assert_select('form') do
          assert_select("div.#{@brand}-form-group") do
            assert_select("label.#{@brand}-label[for='assistant-age-field']", 'Age, yarr')
          end
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
            assert_equal 'assistant-title-field', button['aria-controls']
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
          assert_equal 'assistant-title-hint', hint['id']

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
            assert_equal 'assistant-title-field', button['aria-controls']
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
              assert_equal 'assistant-title-field', button['aria-controls']
              assert_equal 'Show password', button['aria-label']
              assert_equal 'hidden', button['hidden']
            end
          end
        end
      end
    end

    test 'ds_text_area' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-description-field']", 'Description')

          input = assert_select("textarea.#{@brand}-textarea").first
          assert_equal 'assistant-description-field', input['id']
          assert_equal "5", input['rows']
          assert_equal "assistant[description]", input["name"]
        end
      end
    end

    test 'ds_text_area with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-description-field']", 'Description')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-description-hint', hint['id']

          input = assert_select("textarea.#{@brand}-textarea").first
          assert_equal 'assistant-description-hint', input['aria-describedby']
        end
      end
    end

    test 'ds_text_area with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_area(:description, class: 'geoff', placeholder: 'bar', rows: 2, max_words: 20)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group.#{@brand}-character-count[data-module='govuk-character-count'][data-maxwords='20']") do
          assert_select("label.#{@brand}-label[for='assistant-description-field']", 'Description')

          input = assert_select("textarea.#{@brand}-textarea.#{@brand}-js-character-count.geoff[placeholder=bar][rows=2]").first
          assert_equal "2", input['rows']
          assert_equal 'assistant-description-field-info', input['aria-describedby']
          assert_equal "assistant[description]", input["name"]

          info = assert_select("span.#{@brand}-hint.#{@brand}-character-count__message").first
          assert_includes info.text.strip, '20 words'
          assert_equal 'assistant-description-field-info', info['id']
        end
      end
    end

    test 'ds_text_area with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_text_area(:description)
        end

        assert_select('form') do
          assert_select("div.#{@brand}-form-group") do
            assert_select("label.#{@brand}-label[for='assistant-description-field']", 'Description, yarr')
          end
        end
      end
    end

    test 'ds_collection_select' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-department-id-field']", 'Department')

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
    end

    test 'ds_collection_select with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-department-id-field']", 'Department')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-department-id-hint', hint['id']

          select = assert_select("select.#{@brand}-select").first
          assert_equal 'assistant-department-id-hint', select['aria-describedby']
        end
      end
    end

    # TODO: fix this test
    # test 'ds_collection_select with rails options' do
    #   @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
    #     f.ds_collection_select(:department_id, Department.all, :id, :title, prompt: "Please select")
    #   end

    #   assert_select('form') do
    #     assert_select("div.#{@brand}-form-group") do
    #       assert_select("label.#{@brand}-label[for='assistant-department-id-field']", 'Department')

    #       options = assert_select("option")
    #       assert_equal "Please select", options[0].text.strip
    #       assert_equal "", options[0]['value']
    #       assert_equal '1', options[1]['value']
    #       assert_equal 'Sales', options[1].text.strip
    #       assert_equal '2', options[2]['value']
    #       assert_equal 'Marketing', options[2].text.strip
    #       assert_equal '3', options[3]['value']
    #       assert_equal 'Finance', options[3].text.strip
    #     end
    #   end
    # end

    test 'ds_collection_select with html options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_collection_select(:department_id, Department.all, :id, :title, hint: 'This is a hint', class: 'geoff', placeholder: 'bar')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-department-id-field']", 'Department')

          select = assert_select("select.#{@brand}-select.geoff[placeholder=bar]").first
          assert_equal 'assistant-department-id-field', select['id']
          assert_equal 'assistant[department_id]', select['name']

          options = assert_select("option")
          assert_equal '1', options[0]['value']
          assert_equal 'Sales', options[0].text.strip
        end
      end
    end

    test 'ds_select with block' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id) do
          options_for_select(Department.all.map { |department| [department.title, department.id] })
        end
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-department-id-field']", 'Department')

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
    end

    test 'ds_select with label and hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_select(:department_id, options_for_select(Department.all.map { |department| [department.title, department.id] }), label: 'Department label', hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label[for='assistant-department-id-field']", 'Department label')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-department-id-hint', hint['id']

          select = assert_select("select.#{@brand}-select").first
          assert_equal 'assistant-department-id-hint', select['aria-describedby']
        end
      end
    end
  end
end
