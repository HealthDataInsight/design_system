# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk summary card component
      class SummaryCardTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk summary card with title, actions and content' do
          @output_buffer = ds_summary_card(
            title: 'Karen Francis',
            actions: [
              { text: 'Cancel', href: '#', hidden_text: ' (Karen Francis)' },
              { text: 'Reschedule', href: '#', hidden_text: ' (Karen Francis)' }
            ]
          ) do
            ds_summary_list do |list|
              list.add_row('Name', 'Karen Francis')
            end
          end

          assert_select 'div.nhsuk-card' do
            assert_select 'div.nhsuk-card__heading-container' do
              assert_select 'h2.nhsuk-card__heading.nhsuk-heading-m', 'Karen Francis'
              assert_select 'ul.nhsuk-card__actions' do
                assert_select 'li.nhsuk-card__action', count: 2
                assert_select 'li.nhsuk-card__action a.nhsuk-link', text: /Cancel/
                assert_select 'li.nhsuk-card__action a.nhsuk-link span.nhsuk-u-visually-hidden',
                              text: '(Karen Francis)'
              end
            end
            assert_select 'div.nhsuk-card__content dl.nhsuk-summary-list'
          end
        end

        test 'rendering nhsuk summary card with a row action linking to a url' do
          @output_buffer = ds_summary_card(title: 'Karen Francis') do
            ds_summary_list do |list|
              list.add_row('Name', 'Karen Francis') do |row|
                row.add_action('Change', path: '/patients/1/edit', hidden_text: ' name (Karen Francis)')
              end
            end
          end

          assert_select 'div.nhsuk-card__content dl.nhsuk-summary-list' do
            assert_select 'dd.nhsuk-summary-list__actions a.nhsuk-link[href="/patients/1/edit"]', text: /Change/
            assert_select 'dd.nhsuk-summary-list__actions a.nhsuk-link span.nhsuk-u-visually-hidden',
                          text: 'name (Karen Francis)'
          end
        end

        test 'rendering nhsuk summary card without actions omits the list' do
          @output_buffer = ds_summary_card(title: 'No actions') { 'Body' }

          assert_select 'div.nhsuk-card' do
            assert_select 'h2.nhsuk-card__heading', 'No actions'
            assert_select 'ul.nhsuk-card__actions', count: 0
            assert_select 'div.nhsuk-card__content', text: /Body/
          end
        end
      end
    end
  end
end
