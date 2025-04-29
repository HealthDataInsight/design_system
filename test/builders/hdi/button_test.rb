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
          @output_buffer = ds_button_tag('Click', 'data-id': 1)

          assert_select('button.hdi-button', text: 'Click')
          assert_select 'button[data-id]', true, 'Expected button with passed data-attribute option'
        end

        test 'rendering hdi button with disabled attribute' do
          @output_buffer = ds_button_tag('Click', 'data-id': 1, type: :reverse, disabled: true)

          assert_select('button.hdi-button.hdi-button--reverse.hdi-button--disabled', text: 'Click')
        end
      end
    end
  end
end
