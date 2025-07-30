# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the nhsuk panel builder
      class PanelTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk panel' do
          @output_buffer = ds_panel('Important Notice', 'This is important!')

          assert_select 'div.nhsuk-panel' do
            assert_select 'h1.nhsuk-panel__title', 'Important Notice'
            assert_select 'div.nhsuk-panel__body', 'This is important!'
          end
        end
      end
    end
  end
end
