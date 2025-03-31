require 'design_system/registry'

# This concern manages choosing the relevant layout for our given design system
module GovukFormBuilderTestable
  extend ActiveSupport::Concern

  included do
    test 'self.brand' do
      assert_equal @brand, @builder.brand
    end

    # TODO: Test ds_file_field

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

          input = assert_select("input.#{@brand}-input[type=text][id='assistant-title-field']").first
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

          input = assert_select("input.#{@brand}-input[type=text][id='assistant-title-field']").first
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

          input = assert_select("input.#{@brand}-input.geoff[type=text][placeholder=bar][id='assistant-title-field']").first
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

            input = assert_select("input.#{@brand}-input[type=text][id='assistant-title-field']").first
            assert_equal 'AB', input['value']
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

          input = assert_select("input.#{@brand}-input[type=tel][id='assistant-phone-field']").first
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

          input = assert_select("input.#{@brand}-input.#{@brand}-input--width-20.geoff[type=tel][placeholder=bar][id='assistant-phone-field']").first
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

          input = assert_select("input.#{@brand}-input[type=email][id='assistant-email-field']").first
          assert_equal 'ab@example.com', input['value']
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

          input = assert_select("input.#{@brand}-input.geoff[type=email][placeholder=bar][id='assistant-email-field']").first
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

    # test 'ds_password_field' do
    #   @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
    #     f.ds_password_field(:title)
    #   end

    #   assert_select('form') do
    #     assert_select("div.#{@brand}-form-group.#{@brand}-password-input") do
    #       assert_select("label.#{@brand}-label", 'Title')

    #       assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
    #         input = assert_select('input[type=password]').first
    #         assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input", input['class']
    #         assert_equal 'false', input['spellcheck']
    #         assert_equal 'current-password', input['autocomplete']
    #         assert_equal 'none', input['autocapitalize']
    #         assert_nil input['value']

    #         button = assert_select('button[type=button]').first
    #         assert_equal "#{@brand}-button", button['data-module']
    #         assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
    #                      button['class']
    #         assert_equal 'assistant-title-field', button['aria-controls']
    #         assert_equal 'Show password', button['aria-label']
    #         assert_equal 'hidden', button['hidden']
    #       end
    #     end
    #   end
    # end

    # test 'ds_password_field with hint' do
    #   @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
    #     f.ds_password_field(:title, hint: 'This is a hint')
    #   end

    #   assert_select('form') do
    #     assert_select("div.#{@brand}-form-group.#{@brand}-password-input") do
    #       assert_select("label.#{@brand}-label", 'Title')

    #       hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
    #       assert_equal 'assistant-title-hint', hint['id']

    #       assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
    #         input = assert_select('input[type=password]').first
    #         assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input", input['class']
    #         assert_equal 'false', input['spellcheck']
    #         assert_equal 'current-password', input['autocomplete']
    #         assert_equal 'none', input['autocapitalize']
    #         assert_nil input['value']
    #         assert_equal 'assistant-title-hint', input['aria-describedby']

    #         button = assert_select('button[type=button]').first
    #         assert_equal "#{@brand}-button", button['data-module']
    #         assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
    #                      button['class']
    #         assert_equal 'assistant-title-field', button['aria-controls']
    #         assert_equal 'Show password', button['aria-label']
    #         assert_equal 'hidden', button['hidden']
    #       end
    #     end
    #   end
    # end

    # test 'ds_password_field with options' do
    #   @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
    #     f.ds_password_field(:title, class: 'geoff', placeholder: 'bar')
    #   end

    #   assert_select('form') do
    #     assert_select("div.#{@brand}-form-group.#{@brand}-password-input") do
    #       assert_select("label.#{@brand}-label", 'Title')

    #       assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
    #         input = assert_select('input[type=password][placeholder=bar]').first
    #         assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input geoff", input['class']
    #         assert_equal 'false', input['spellcheck']
    #         assert_equal 'current-password', input['autocomplete']
    #         assert_equal 'none', input['autocapitalize']
    #         assert_nil input['value']

    #         button = assert_select('button[type=button]').first
    #         assert_equal "#{@brand}-button", button['data-module']
    #         assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
    #                      button['class']
    #         assert_equal 'assistant-title-field', button['aria-controls']
    #         assert_equal 'Show password', button['aria-label']
    #         assert_equal 'hidden', button['hidden']
    #       end
    #     end
    #   end
    # end

    # test 'ds_password_field with pirate locale' do
    #   I18n.with_locale :pirate do
    #     @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
    #       f.ds_password_field(:title)
    #     end

    #     assert_select('form') do
    #       assert_select("div.#{@brand}-form-group.#{@brand}-password-input") do
    #         assert_select("label.#{@brand}-label", 'Title, yarr')

    #         assert_select("div.#{@brand}-input__wrapper.#{@brand}-password-input__wrapper") do
    #           input = assert_select('input[type=password]').first
    #           assert_equal "#{@brand}-input #{@brand}-password-input__input #{@brand}-js-password-input-input", input['class']
    #           assert_equal 'false', input['spellcheck']
    #           assert_equal 'current-password', input['autocomplete']
    #           assert_equal 'none', input['autocapitalize']
    #           assert_nil input['value']

    #           button = assert_select('button[type=button]').first
    #           assert_equal "#{@brand}-button", button['data-module']
    #           assert_equal "#{@brand}-button #{@brand}-button--secondary #{@brand}-password-input__toggle #{@brand}-js-password-input-toggle",
    #                        button['class']
    #           assert_equal 'assistant-title-field', button['aria-controls']
    #           assert_equal 'Show password', button['aria-label']
    #           assert_equal 'hidden', button['hidden']
    #         end
    #       end
    #     end
    #   end
    # end

    # TODO: Test ds_text_area
  end
end
