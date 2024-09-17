# This concern manages choosing the relevant layout for our given design system
module GovukFormBuilderTestable
  extend ActiveSupport::Concern

  included do
    test 'self.brand' do
      assert_equal @brand, @builder.brand
    end

    test 'ds_label' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        concat f.ds_label(:title)
      end

      assert_select('form') do
        assert_select("label.#{@brand}-label", 'Title')
      end
    end

    test 'ds_label with content' do
      @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
        concat f.ds_label(:title, 'Titlezzz')
      end

      assert_select('form') do
        assert_select("label.#{@brand}-label", 'Titlezzz')
      end
    end

    test 'ds_label with pirate locale' do
      I18n.with_locale :pirate do
        @output_buffer = form_with(model: assistants(:one), builder: @builder) do |f|
          concat f.ds_label(:title)
        end

        assert_select('form') do
          assert_select("label.#{@brand}-label", 'Title, yarr')
        end
      end
    end
  end
end
