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

    test 'separate_options_and_value with options and unchecked_value' do
      options, value, unchecked_value = @builder.send(:separate_options_and_value, { hint: 'This is a hint' }, 'yes', 'no')

      assert_equal({ hint: 'This is a hint' }, options)
      assert_equal('yes', value)
      assert_equal('no', unchecked_value)
    end

    test 'separate_options_and_value with options, without unchecked_value' do
      options, value, unchecked_value = @builder.send(:separate_options_and_value, { hint: 'This is a hint' }, 'yes', '0')

      assert_equal({ hint: 'This is a hint' }, options)
      assert_equal('yes', value)
      assert_equal(false, unchecked_value)
    end

    test 'separate_options_and_value without options, with unchecked_value' do
      options, value, unchecked_value = @builder.send(:separate_options_and_value, 'yes', 'no', '0')

      assert_equal({}, options)
      assert_equal('yes', value)
      assert_equal('no', unchecked_value)
    end

    test 'separate_options_and_value without options or unchecked_value' do
      options, value, unchecked_value = @builder.send(:separate_options_and_value, 'yes', '1', '0')

      assert_equal({}, options)
      assert_equal('yes', value)
      assert_equal(false, unchecked_value)
    end
  end
end
