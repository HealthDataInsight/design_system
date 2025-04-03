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

    test 'separate_rails_or_html_options with Rails options' do
      options = { include_blank: true, prompt: 'Select a department' }
      html_options = { class: 'my-class' }

      result_options, result_html_options = @builder.send(:separate_rails_or_html_options, options, html_options)

      assert_equal options, result_options
      assert_equal html_options, result_html_options
    end

    test 'separate_rails_or_html_options with HTML options as options' do
      options = { class: 'my-class', data: { foo: 'bar' } }
      html_options = nil

      result_options, result_html_options = @builder.send(:separate_rails_or_html_options, options, html_options)

      assert_nil result_options
      assert_equal options, result_html_options
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
