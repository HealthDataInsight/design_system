require 'test_helper'

module DesignSystem
  module Govuk
    module Components
      # This tests the govuk summary list component
      class SummaryListTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('govuk')
        end

        test 'renders a basic govuk summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X', value: 'Y')
          end

          assert_select('dl.govuk-summary-list')
          assert_select('div.govuk-summary-list__row')
          assert_select('dt.govuk-summary-list__key', text: 'X')
          assert_select('dd.govuk-summary-list__value', text: 'Y')
          # A single value renders inline, not wrapped in a govuk-body paragraph.
          assert_select('dd.govuk-summary-list__value p', count: 0)
        end

        test 'renders multiple value in a summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X') do |row|
              row.add_value('Y')
              row.add_value('Z')
            end
          end

          assert_select('dt.govuk-summary-list__key', text: 'X')
          assert_select('dd.govuk-summary-list__value p', text: 'Y')
          assert_select('dd.govuk-summary-list__value p', text: 'Z')
        end

        test 'renders a summary list with a linked value' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Website') do |row|
              row.add_value('Visit', { path: 'https://example.com' })
            end
          end

          assert_select('dd.govuk-summary-list__value', text: 'Visit') do
            assert_select('a.govuk-link[href="https://example.com"]')
          end
        end

        test 'renders a summary list with an action and hidden text' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Actions') do |row|
              row.add_action('Edit', { path: '/edit', hidden_text: 'this record' })
            end
          end

          assert_select('dd.govuk-summary-list__actions') do
            assert_select("a.govuk-link[href='/edit']") do
              assert_select('span.govuk-visually-hidden', text: 'this record')
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

          assert_select('dd.govuk-summary-list__actions')
          assert_select('ul.govuk-summary-list__actions-list')
          assert_select("li.govuk-summary-list__actions-list-item a[href='/edit']", text: 'Edit')
          assert_select("li.govuk-summary-list__actions-list-item a[href='/delete']", text: 'Delete')
        end

        test 'renders an action with custom html options' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Definition') do |row|
              row.add_action('View definition', path: '#definition', hidden_text: 'of the cohort',
                                                target: 'data-cohort')
            end
          end

          assert_select("dd.govuk-summary-list__actions a.govuk-link[target='data-cohort']",
                        text: /View definition/)
        end

        test 'renders without actions' do
          @output_buffer = ds_summary_list do |list|
            list.add_row('Age', 30)
          end

          assert_select('div.govuk-summary-list__row.govuk-summary-list__row--no-actions') do
            assert_select('dt.govuk-summary-list__key', text: 'Age')
            assert_select('dd.govuk-summary-list__value', text: '30')
            assert_select('dd.govuk-summary-list__actions', text: '', count: 0)
          end
        end

        test 'renders an empty value cell when values are nil' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Age') do |row|
              row.add_action('View', { path: '/view' })
            end
          end

          assert_select('div.govuk-summary-list__row') do
            assert_select('dt.govuk-summary-list__key', text: 'Age')
            assert_select('dd.govuk-summary-list__value', text: '')
            assert_select("dd.govuk-summary-list__actions a[href='/view']", text: 'View')
          end
        end
      end
    end
  end
end
