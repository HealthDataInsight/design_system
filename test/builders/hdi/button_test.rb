# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Hdi
      # This tests the hdi button builder
      class ButtonTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi button' do
          @output_buffer = ds_button_tag('Click', style: 'primary', 'data-id': 1)

          assert_select('button.hdi-button', text: 'Click')
          assert_select 'button[data-id]', true, 'Expected button with passed data-attribute option'
        end

        test 'rendering hdi button with secondary style' do
          @output_buffer = ds_button_tag('Click', style: 'secondary', 'data-id': 1)

          assert_select('button.hdi-button', text: 'Click')
        end

        test 'rendering hdi button with warning style' do
          @output_buffer = ds_button_tag('Click', style: 'warning', 'data-id': 1)

          assert_select('button.hdi-button', text: 'Click')
        end

        test 'rendering hdi button with disabled style' do
          @output_buffer = ds_button_tag('Click', style: 'primary', disabled: true)

          assert_select('button.hdi-button', text: 'Click')
        end

        test 'rendering hdi button with secondary style and disabled' do
          @output_buffer = ds_button_tag('Click', style: 'secondary', disabled: true)

          assert_select('button.hdi-button', text: 'Click')
        end

        test 'rendering hdi button with warning style and disabled' do
          @output_buffer = ds_button_tag('Click', style: 'warning', disabled: true)

          assert_select('button.hdi-button', text: 'Click')
        end
      end
    end
  end
end
