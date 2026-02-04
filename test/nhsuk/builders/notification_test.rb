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

            assert_select 'div.nhsuk-notification-banner__content' do
              assert_select 'p.nhsuk-notification-banner__heading', 'Important Notice'
            end
          end
        end

        test 'rendering nhsuk notice with custom header' do
          @output_buffer = ds_notice('Test content', header: 'Custom header')

          assert_select 'div.nhsuk-notification-banner[role="region"][aria-labelledby="nhsuk-notification-banner-title"][data-module="nhsuk-notification-banner"]' do
            assert_select 'div.nhsuk-notification-banner__header' do
              assert_select 'h2.nhsuk-notification-banner__title[id="nhsuk-notification-banner-title"]', 'Custom header'
            end
          end
        end

        test 'rendering nhsuk notice with success type' do
          @output_buffer = ds_notice('Test content', type: :success)

          assert_select 'div.nhsuk-notification-banner.nhsuk-notification-banner--success[role="alert"][aria-labelledby="nhsuk-notification-banner-title"][data-module="nhsuk-notification-banner"]' do
            assert_select 'div.nhsuk-notification-banner__header' do
              assert_select 'h2.nhsuk-notification-banner__title[id="nhsuk-notification-banner-title"]', 'Success'
            end

            assert_select 'div.nhsuk-notification-banner__content' do
              assert_select 'p.nhsuk-notification-banner__heading', 'Test content'
            end
          end
        end

        test 'rendering nhsuk notice with success type and custom header' do
          @output_buffer = ds_notice('Test content', type: :success, header: 'Custom header')

          assert_select 'div.nhsuk-notification-banner.nhsuk-notification-banner--success[role="alert"][aria-labelledby="nhsuk-notification-banner-title"][data-module="nhsuk-notification-banner"]' do
            assert_select 'div.nhsuk-notification-banner__header' do
              assert_select 'h2.nhsuk-notification-banner__title[id="nhsuk-notification-banner-title"]', 'Custom header'
            end

            assert_select 'div.nhsuk-notification-banner__content' do
              assert_select 'p.nhsuk-notification-banner__heading', 'Test content'
            end
          end
        end

        test 'rendering nhsuk notice with HTML content via block' do
          @output_buffer = ds_notice do
            '<b>Important Notice:<br> check link <a href="/"> here </a></b>'.html_safe
          end

          assert_select 'div.nhsuk-notification-banner' do
            assert_select 'div.nhsuk-notification-banner__content' do
              assert_select 'p.nhsuk-notification-banner__heading' do
                assert_select 'b', text: 'Important Notice: check link  here' do
                  assert_select 'a', text: 'here'
                end
              end
            end
          end
        end

        test 'rendering nhsuk notice with link inside the block' do
          @output_buffer = ds_notice do
            ds_link_to('link', '#')
          end

          assert_select 'div.nhsuk-notification-banner' do
            assert_select 'div.nhsuk-notification-banner__content' do
              assert_select 'p.nhsuk-notification-banner__heading' do
                assert_select 'a.nhsuk-notification-banner__link[href="#"]', 'link'
              end
            end
          end
        end
      end
    end
  end
end
