# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk notification builder
      class NotificationTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk notice' do
          @output_buffer = ds_notice('Important Notice')

          assert_select 'div.govuk-notification-banner' do
            assert_select 'div.govuk-notification-banner__header' do
              assert_select 'h2.govuk-notification-banner__title', 'Important'
            end

            assert_select 'div.govuk-notification-banner__content' do
              assert_select 'p.govuk-notification-banner__heading', 'Important Notice'
            end
          end
        end

        test 'rendering govuk alert' do
          @output_buffer = ds_alert('Test alert!')

          assert_select 'div.govuk-error-summary' do
            assert_select 'h2.govuk-error-summary__title', 'Test alert!'
          end
        end

        test 'rendering govuk notice with block' do
          @output_buffer = ds_notice do
            '<strong>Notice:</strong> Complex content with <a href="#">link</a>'.html_safe
          end

          assert_select 'div.govuk-notification-banner' do
            assert_select 'div.govuk-notification-banner__content' do
              assert_select 'p.govuk-notification-banner__heading' do
                assert_select 'strong', 'Notice:'
                assert_select 'a[href="#"]', 'link'
              end
            end
          end
        end

        test 'rendering govuk alert with block' do
          @output_buffer = ds_alert do
            '<strong>Error:</strong> Check <a href="/help">help page</a>'.html_safe
          end

          assert_select 'div.govuk-error-summary' do
            assert_select 'h2.govuk-error-summary__title' do
              assert_select 'strong', 'Error:'
              assert_select 'a[href="/help"]', 'help page'
            end
          end
        end
      end
    end
  end
end
