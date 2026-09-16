# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk code component
      class CodeTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering a code block with a copy button' do
          @output_buffer = ds_code('<p>hello</p>', 'xml')

          assert_select('div.app-example__code[data-controller="ds--clipboard"]') do
            assert_select('button.app-example__copy-button[data-action="click->ds--clipboard#copy"]', text: 'Copy')
            assert_select('div.app-example__scroll[tabindex="0"] pre code.hljs.language-xml', text: '<p>hello</p>')
          end
        end
      end
    end
  end
end
