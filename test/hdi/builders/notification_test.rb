# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Hdi
    module Builders
      # This tests the hdi notification builder
      class NotificationTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi notice' do
          @output_buffer = ds_notice('Important Notice')
          assert_select 'div.hdi-notification-banner' do
            assert_select 'svg.hdi-icon__information-circle'
            assert_select 'span', 'Important Notice'
          end
        end

        test 'rendering hdi alert' do
          @output_buffer = ds_alert('Test alert!')

          assert_select 'div.hdi-notification-banner.hdi-notification-banner__alert' do
            assert_select 'svg.hdi-icon__exclamation-circle'
            assert_select 'span', 'Test alert!'
          end
        end

        test 'rendering hdi alert with sanitisation' do
          @output_buffer = ds_alert('<p>Test alert!</p>')

          assert_select 'div.hdi-notification-banner.hdi-notification-banner__alert' do
            assert_select 'svg.hdi-icon__exclamation-circle'
            assert_select 'span', text: 'Test alert!'
          end
        end
      end
    end
  end
end
