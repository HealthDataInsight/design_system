require 'test_helper'
require 'design_system/form_builders/hdi'
require 'design_system/registry'

module FormBuilders
  class HdiTest < ActionView::TestCase
    def setup
      @brand = 'hdi'
      @builder = DesignSystem::FormBuilders::Hdi
    end

    test 'self.brand' do
      assert_equal @brand, @builder.brand
    end

    test 'Registry.form_builder returns Hdi form builder' do
      assert_equal DesignSystem::FormBuilders::Hdi,
                   DesignSystem::Registry.form_builder(@brand)
    end

    # TODO: Test ds_file_field

    test 'ds_label' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_label(:title)
      end

      assert_select('form') do
        assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title')
      end
    end

    test 'ds_label with content and options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_label(:title, 'Titlezzz', class: 'bob', 'data-foo': 'bar')
      end

      assert_select('form') do
        assert_select('label.bob.block.text-sm.font-medium.leading-6.text-gray-900[data-foo=bar]', 'Titlezzz')
      end
    end

    test 'ds_label with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_label(:title)
        end

        assert_select('form') do
          assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title, yarr')
        end
      end
    end

    test 'ds_password_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title)
      end

      assert_select('form') do
        assert_select('div') do
          assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title')
          assert_select('div.mt-2') do
            input = assert_select('input[type=password]').first
            assert_equal 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6',
                         input['class']
            assert_equal 'false', input['spellcheck']
            assert_equal 'current-password', input['autocomplete']
            assert_equal 'none', input['autocapitalize']
            assert_nil input['value']
          end
        end
      end
    end

    test 'ds_password_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select('div') do
          assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title')

          hint = assert_select('p', 'This is a hint').first
          assert_equal 'mt-2 text-sm text-gray-500', hint['class']
          assert_equal 'assistant_title-hint', hint['id']

          assert_select('div.mt-2') do
            input = assert_select('input[type=password]').first
            assert_equal 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6',
                         input['class']
            assert_equal 'false', input['spellcheck']
            assert_equal 'current-password', input['autocomplete']
            assert_equal 'none', input['autocapitalize']
            assert_nil input['value']
            assert_equal 'assistant_title-hint', input['aria-describedby']
          end
        end
      end
    end

    test 'ds_password_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_password_field(:title, class: 'geoff', placeholder: 'bar')
      end

      assert_select('form') do
        assert_select('div') do
          assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900')
          assert_select('div.mt-2') do
            input = assert_select('input[type=password][placeholder=bar]').first
            assert_equal 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6 geoff',
                         input['class']
            assert_equal 'false', input['spellcheck']
            assert_equal 'current-password', input['autocomplete']
            assert_equal 'none', input['autocapitalize']
            assert_nil input['value']
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
          assert_select('div') do
            assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title, yarr')
            assert_select('div.mt-2') do
              input = assert_select('input[type=password]').first
              assert_equal 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6',
                           input['class']
              assert_equal 'false', input['spellcheck']
              assert_equal 'current-password', input['autocomplete']
              assert_equal 'none', input['autocapitalize']
              assert_nil input['value']
            end
          end
        end
      end
    end

    # TODO: Test ds_text_area

    test 'ds_text_field' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title)
      end

      assert_select('form') do
        assert_select('div') do
          assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title')
          assert_select('div.mt-2') do
            input = assert_select('input[type=text]').first
            assert_equal 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6',
                         input['class']
            assert_equal 'Lorem ipsum dolor sit amet', input['value']
          end
        end
      end
    end

    test 'ds_text_field with hint' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, hint: 'This is a hint')
      end

      assert_select('form') do
        assert_select('div') do
          assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title')

          hint = assert_select('p', 'This is a hint').first
          assert_equal 'mt-2 text-sm text-gray-500', hint['class']
          assert_equal 'assistant_title-hint', hint['id']

          assert_select('div.mt-2') do
            input = assert_select('input[type=text]').first
            assert_equal 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6',
                         input['class']
            assert_equal 'Lorem ipsum dolor sit amet', input['value']
            assert_equal 'assistant_title-hint', input['aria-describedby']
          end
        end
      end
    end

    test 'ds_text_field with options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        f.ds_text_field(:title, class: 'geoff', placeholder: 'bar')
      end

      assert_select('form') do
        assert_select('div') do
          assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900')
          assert_select('div.mt-2') do
            input = assert_select('input[type=text][placeholder=bar]').first
            assert_equal 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6 geoff',
                         input['class']
            assert_equal 'Lorem ipsum dolor sit amet', input['value']
          end
        end
      end
    end

    test 'ds_text_field with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          f.ds_text_field(:title)
        end

        assert_select('form') do
          assert_select('div') do
            assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title, yarr')
            assert_select('div.mt-2') do
              input = assert_select('input[type=text]').first
              assert_equal 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6',
                           input['class']
              assert_equal 'Lorem ipsum dolor sit amet', input['value']
            end
          end
        end
      end
    end
  end
end
