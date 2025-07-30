# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Hdi
    module Builders
      # This tests the hdi button builder
      class ButtonTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi button' do
          @output_buffer = ds_button_tag('Click', style: 'primary', 'data-id': 1)

          assert_select('button.bg-indigo-600', text: 'Click')
          assert_select 'button[data-id]', true, 'Expected button with passed data-attribute option'
        end
      end
    end
  end
end
