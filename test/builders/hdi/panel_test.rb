# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Hdi
      # This tests the hdi panel builder
      class PanelTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi panel' do
          @output_buffer = ds_panel('Important Notice', 'This is important!')

          assert_select 'div.block' do
            assert_select 'h1.mb-2', 'Important Notice'
            assert_select 'p.font-normal', 'This is important!'
          end
        end
      end
    end
  end
end
