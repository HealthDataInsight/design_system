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

          assert_select 'div.nhsuk-notification-banner' do
            assert_select 'div.nhsuk-notification-banner__header' do
              assert_select 'h2.nhsuk-notification-banner__title', 'Important'
            end

            assert_select 'div.nhsuk-notification-banner__content', text: 'Important Notice'
          end
        end

        test 'rendering nhsuk notice with success type' do
          @output_buffer = ds_notice('Test content', type: :success)

          assert_select 'div.nhsuk-notification-banner.nhsuk-notification-banner--success[role="alert"][aria-labelledby="nhsuk-notification-banner-title"][data-module="nhsuk-notification-banner"]' do
            assert_select 'div.nhsuk-notification-banner__header' do
              assert_select 'h2.nhsuk-notification-banner__title[id="nhsuk-notification-banner-title"]', 'Success'
            end

            assert_select 'div.nhsuk-notification-banner__content', text: 'Test content'
          end
        end

        test 'rendering nhsuk alert' do
          @output_buffer = ds_alert('Test alert!')

          assert_select 'div.nhsuk-error-summary' do
            assert_select 'h2.nhsuk-error-summary__title', 'Test alert!'
          end
        end

        test 'rendering nhsuk notice with content heading and body (msg)' do
          @output_buffer = ds_notice('Body', content_heading: { text: 'Important Notice', tag: :p })

          assert_select 'div.nhsuk-notification-banner__content' do
            assert_select 'p.nhsuk-notification-banner__heading', 'Important Notice'
          end
        end

        test 'rendering nhsuk notice without content heading' do
          @output_buffer = ds_notice do
            '<p class="custom">Raw content</p>'.html_safe
          end

          assert_select 'div.nhsuk-notification-banner__content' do
            assert_select 'p.custom', 'Raw content'
            assert_select '.nhsuk-notification-banner__heading', count: 0
          end
        end

        test 'rendering nhsuk notice with heading and body(block)' do
          @output_buffer = ds_notice(content_heading: { text: 'Banner heading', tag: :h3 }) do
            '<p class="body">Additional content</p>'.html_safe
          end

          assert_select 'div.nhsuk-notification-banner__content' do
            assert_select 'h3.nhsuk-notification-banner__heading', 'Banner heading'
            assert_select 'p.body', 'Additional content'
          end
        end

        test 'rendering nhsuk notice with link inside the block' do
          @output_buffer = ds_notice do
            ds_link_to('link', '#')
          end

          assert_select 'div.nhsuk-notification-banner' do
            assert_select 'div.nhsuk-notification-banner__content' do
              assert_select 'a.nhsuk-notification-banner__link[href="#"]', 'link'
            end
          end
        end
      end
    end
  end
end
