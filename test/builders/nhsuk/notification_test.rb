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

        test 'rendering nhsuk notice with sanitizing content' do
          @output_buffer = ds_notice('<b>Important Notice:<br> check link <a href="/"> here </a></b>')
          assert_select 'div.nhsuk-warning-callout' do
            assert_select 'h3.nhsuk-warning-callout__label', 'Important:'
            assert_select 'p' do
              assert_select 'b', text: 'Important Notice: check link  here' do
                assert_select 'a', text: 'here'
              end
            end
          end
        end
      end
    end
  end
end
