# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Hdi
      # This tests the hdi notification builder
      class NotificationTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi notice' do
          @output_buffer = ds_notice('Important Notice')
          assert_select 'div.rounded-md.bg-blue-50.dark\\:bg-blue-900.p-4.mb-4' do
            assert_select 'div.flex' do
              assert_select 'div.flex-shrink-0'
            end

            assert_select 'div.ml-3.flex-1.md\\:flex.md\\:justify-between' do
              assert_select 'p.text-sm.text-blue-700.dark\\:text-white', 'Important Notice'
            end
          end
        end

        test 'rendering hdi alert' do
          @output_buffer = ds_alert('Test alert!')

          assert_select 'div.rounded-md.bg-red-50.dark\\:bg-red-900.p-4.mb-4' do
            assert_select 'div.text-sm.text-red-700.dark\\:text-white', 'Test alert!'
          end
        end

        test 'rendering hdi alert with sanitisation' do
          @output_buffer = ds_alert('<p>Test alert!</p>')

          assert_select 'div.rounded-md.bg-red-50.dark\\:bg-red-900.p-4.mb-4' do
            assert_select 'div.text-sm.text-red-700.dark\\:text-white' do
              assert_select 'p', text: 'Test alert!'
            end
          end
        end
      end
    end
  end
end
