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

    test 'separate_rails_or_html_options with nil options' do
      options = nil
      html_options = { class: 'my-class' }

      result_options, result_html_options = @builder.send(:separate_rails_or_html_options, options, html_options)

      assert_nil result_options
      assert_equal html_options, result_html_options
    end

    test 'separate_rails_or_html_options with both options and html_options' do
      options = { include_blank: true }
      html_options = { class: 'my-class' }

      result_options, result_html_options = @builder.send(:separate_rails_or_html_options, options, html_options)

      assert_equal options, result_options
      assert_equal html_options, result_html_options
    end
  end
end
