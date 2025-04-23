require 'test_helper'
require 'design_system/form_builders/govuk'
require_relative 'concerns/govuk_form_builder_testable'

module FormBuilders
  class BaseTest < ActionView::TestCase
    include DesignSystem::FormBuilders

    def setup
      super
      @builder = Base.new('test', 'test', self, {})
    end

    test 'separate_choices_or_options without choices' do
      choices, options, html_options = @builder.send(:separate_choices_or_options, { hint: 'This is a hint' }, { class: 'geoff' })

      assert_equal [], choices
      assert_equal({ hint: 'This is a hint' }, options)
      assert_equal({ class: 'geoff' }, html_options)
    end
  end
end
