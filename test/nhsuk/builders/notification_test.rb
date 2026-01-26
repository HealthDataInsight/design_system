# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the nhsuk notification builder
      class NotificationTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk notice' do
          @output_buffer = ds_notice('Important Notice')
          assert_select 'div.nhsuk-inset-text' do
            assert_select 'span', 'Information:'
            assert_select 'p', 'Important Notice'
          end
        end

        test 'rendering nhsuk notice with HTML content via block' do
          @output_buffer = ds_notice do
            '<b>Important Notice:<br> check link <a href="/"> here </a></b>'.html_safe
          end
          assert_select 'div.nhsuk-inset-text' do
            assert_select 'span', 'Information:'
            assert_select 'p' do
              assert_select 'b', text: 'Important Notice: check link  here' do
                assert_select 'a', text: 'here'
              end
            end
          end
        end

        test 'rendering nhsuk notice with block' do
          @output_buffer = ds_notice do
            '<strong>Notice:</strong> Block content with <a href="#">link</a>'.html_safe
          end

          assert_select 'div.nhsuk-inset-text' do
            assert_select 'span', 'Information:'
            assert_select 'p' do
              assert_select 'strong', 'Notice:'
              assert_select 'a[href="#"]', 'link'
            end
          end
        end
      end
    end
  end
end
