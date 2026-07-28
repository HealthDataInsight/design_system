# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk alert component
      class AlertTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('nhsuk')
        end

        test 'rendering nhsuk alert' do
          @output_buffer = ds_alert('Test alert!')

          assert_select 'div.nhsuk-error-summary' do
            assert_select 'h2.nhsuk-error-summary__title', 'Test alert!'
          end
        end
      end
    end
  end
end
