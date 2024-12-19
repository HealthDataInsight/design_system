# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Nhsuk
      # This tests the nhsuk notification builder
      class NotificationTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk notice' do
          @output_buffer = ds_notice('Important Notice')
          assert_select 'div.nhsuk-warning-callout' do
            assert_select 'h3.nhsuk-warning-callout__label', 'Important:'
            assert_select 'p', 'Important Notice'
          end
        end
      end
    end
  end
end
