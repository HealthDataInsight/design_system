require 'test_helper'

module Generic
  class FormBuilderTest < ActionView::TestCase
    def setup
      @builder = DesignSystem::Generic::FormBuilder.new('test', 'test', self, {})
    end

    test 'separate_choices_or_options without choices' do
      choices, options, html_options = @builder.send(:separate_choices_or_options, { hint: 'This is a hint' }, { class: 'geoff' })

      assert_equal [], choices
      assert_equal({ hint: 'This is a hint' }, options)
      assert_equal({ class: 'geoff' }, html_options)
    end
  end
end
