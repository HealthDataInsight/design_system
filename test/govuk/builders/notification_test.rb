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
          end

          assert_select 'div.govuk-notification-banner__content', text: 'Important Notice'
        end

        test 'rendering govuk notice with success type' do
          @output_buffer = ds_notice('Test content', type: :success)

          assert_select 'div.govuk-notification-banner.govuk-notification-banner--success[role="alert"][aria-labelledby="govuk-notification-banner-title"][data-module="govuk-notification-banner"]' do
            assert_select 'div.govuk-notification-banner__header' do
              assert_select 'h2.govuk-notification-banner__title[id="govuk-notification-banner-title"]', 'Success'
            end

            assert_select 'div.govuk-notification-banner__content', text: 'Test content'
          end
        end

        test 'rendering govuk alert' do
          @output_buffer = ds_alert('Test alert!')

          assert_select 'div.govuk-error-summary' do
            assert_select 'h2.govuk-error-summary__title', 'Test alert!'
          end
        end

        test 'rendering govuk notice with content heading and body (msg)' do
          @output_buffer = ds_notice('Important Notice', content_heading: { text: 'Important Notice', tag: :p })

          assert_select 'div.govuk-notification-banner__content' do
            assert_select 'p.govuk-notification-banner__heading', 'Important Notice'
          end
        end

        test 'rendering govuk notice with content heading default tag' do
          @output_buffer = ds_notice('Body', content_heading: { text: 'Important Notice' })

          assert_select 'div.govuk-notification-banner__content' do
            assert_select 'h3.govuk-notification-banner__heading', 'Important Notice'
          end
        end

        test 'rejecting invalid content heading tag' do
          error = assert_raises(ArgumentError) do
            ds_notice('Body', content_heading: { text: 'Heading', tag: :div })
          end

          assert_match(/Invalid content_heading tag/i, error.message)
        end

        test 'rendering govuk notice without content heading' do
          @output_buffer = ds_notice do
            '<p class="custom">Raw content</p>'.html_safe
          end

          assert_select 'div.govuk-notification-banner__content' do
            assert_select 'p.custom', 'Raw content'
            assert_select '.govuk-notification-banner__heading', count: 0
          end
        end

        test 'rendering govuk notice with heading and body(block)' do
          @output_buffer = ds_notice(content_heading: { text: 'Banner heading', tag: :h3 }) do
            '<p class="body">Additional content</p>'.html_safe
          end

          assert_select 'div.govuk-notification-banner__content' do
            assert_select 'h3.govuk-notification-banner__heading', 'Banner heading'
            assert_select 'p.body', 'Additional content'
          end
        end

        test 'rendering govuk notice with link inside the block' do
          @output_buffer = ds_notice do
            ds_link_to('link', '#')
          end

          assert_select 'div.govuk-notification-banner' do
            assert_select 'div.govuk-notification-banner__content' do
              assert_select 'a.govuk-notification-banner__link[href="#"]', 'link'
            end
          end
        end
      end
    end
  end
end
