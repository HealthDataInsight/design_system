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

    
    # TODO: Test ds_text_area

    test 'ds_text_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title)
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label", 'Title')

          input = assert_select("input.#{@brand}-input[type=text]").first
          assert_equal 'Lorem ipsum dolor sit amet', input['value']
        end
      end
    end

    test 'ds_text_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select("div.#{@brand}-form-group") do
          assert_select("label.#{@brand}-label", 'Title')

          hint = assert_select("div.#{@brand}-hint", 'This is a hint').first
          assert_equal 'assistant-title-hint', hint['id']

          input = assert_select("input.#{@brand}-input[type=text]").first
          assert_equal 'Lorem ipsum dolor sit amet', input['value']
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
          assert_select("label.#{@brand}-label", 'Title')

          input = assert_select("input.#{@brand}-input.geoff[type=text][placeholder=bar]").first
          assert_equal 'Lorem ipsum dolor sit amet', input['value']
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
            assert_select("label.#{@brand}-label", 'Title, yarr')

            input = assert_select("input.#{@brand}-input[type=text]").first
            assert_equal 'Lorem ipsum dolor sit amet', input['value']
          end
        end
      end
    end
  end
end
