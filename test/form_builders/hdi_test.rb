require 'test_helper'
require 'design_system/form_builders/hdi'

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

    test 'ds_label' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        concat f.ds_label(:title)
      end

      assert_select('form') do
        assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title')
      end
    end

    test 'ds_label with content and options' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        concat f.ds_label(:title, 'Titlezzz', class: 'bob', 'data-foo': 'bar')
      end

      assert_select('form') do
        assert_select('label.bob.block.text-sm.font-medium.leading-6.text-gray-900[data-foo=bar]', 'Titlezzz')
      end
    end

    test 'ds_label with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          concat f.ds_label(:title)
        end

        assert_select('form') do
          assert_select('label.block.text-sm.font-medium.leading-6.text-gray-900', 'Title, yarr')
        end
      end
    end
  end
end
