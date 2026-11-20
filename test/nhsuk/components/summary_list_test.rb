require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk summary list component
      class SummaryListTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('nhsuk')
        end

        test 'renders a basic nhsuk summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X', value: 'Y')
          end

          assert_select('dl.nhsuk-summary-list')
          assert_select('div.nhsuk-summary-list__row')
          assert_select('dt.nhsuk-summary-list__key', text: 'X')
          assert_select('dd.nhsuk-summary-list__value', text: 'Y')
        end

        test 'renders multiple value in a summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X') do |row|
              row.add_value('Y')
              row.add_value('Z')
            end
          end

          assert_select('dt.nhsuk-summary-list__key', text: 'X')
          assert_select('dd.nhsuk-summary-list__value p', text: 'Y')
          assert_select('dd.nhsuk-summary-list__value p', text: 'Z')
        end

        test 'renders a summary list with an action and hidden text' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Actions') do |row|
              row.add_action('Edit', { path: '/edit', hidden_text: 'this record' })
            end
          end

          assert_select('dd.nhsuk-summary-list__actions') do
            assert_select("a.nhsuk-link[href='/edit']") do
              assert_select('span.nhsuk-u-visually-hidden', text: 'this record')
            end
          end
        end

        test 'renders multiple actions in a summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Actions') do |row|
              row.add_value('Item')
              row.add_action('Edit', { path: '/edit' })
              row.add_action('Delete', { path: '/delete' })
            end
          end

          assert_select('dd.nhsuk-summary-list__actions')
          assert_select('ul.nhsuk-summary-list__actions-list')
          assert_select("li.nhsuk-summary-list__actions-list-item a[href='/edit']", text: 'Edit')
          assert_select("li.nhsuk-summary-list__actions-list-item a[href='/delete']", text: 'Delete')
        end

        test 'renders an action with custom html options' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Definition') do |row|
              row.add_action('View definition', path: '#definition', hidden_text: 'of the cohort',
                                                target: 'data-cohort')
            end
          end

          assert_select("dd.nhsuk-summary-list__actions a.nhsuk-link[target='data-cohort']",
                        text: /View definition/)
        end

        test 'renders without actions' do
          @output_buffer = ds_summary_list do |list|
            list.add_row('Age', 30)
          end

          assert_select('div.nhsuk-summary-list__row.nhsuk-summary-list__row--no-actions') do
            assert_select('dt.nhsuk-summary-list__key', text: 'Age')
            assert_select('dd.nhsuk-summary-list__value', text: '30')
            assert_select('dd.nhsuk-summary-list__actions', text: '', count: 0)
          end
        end

        test 'renders an empty value cell when values are nil' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Age') do |row|
              row.add_action('View', { path: '/view' })
            end
          end

          assert_select('div.nhsuk-summary-list__row') do
            assert_select('dt.nhsuk-summary-list__key', text: 'Age')
            assert_select('dd.nhsuk-summary-list__value', text: '')
            assert_select("dd.nhsuk-summary-list__actions a[href='/view']", text: 'View')
          end
        end

        test 'renders width classes on the key, value and actions columns' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Definition') do |row|
              row.add_key('Definition', width: :one_quarter)
              row.add_value('Cohort', width: :half)
              row.add_action('Definition (opens in a new tab)', path: '/d', target: '_blank', width: :one_third)
            end
          end

          assert_select('dt.nhsuk-summary-list__key.nhsuk-u-width-one-quarter')
          assert_select('dd.nhsuk-summary-list__value.nhsuk-u-width-one-half')
          assert_select('dd.nhsuk-summary-list__actions.nhsuk-u-width-one-third') do
            assert_select("a[target='_blank']:not([width])", text: /Definition/)
          end
        end

        test 'raises an error for an unknown width' do
          assert_raises(ArgumentError) do
            ds_summary_list do |list|
              list.add_row(key: 'X') { |row| row.add_action('Edit', width: :enormous) }
            end
          end
        end
      end
    end
  end
end
