require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the nhsuk summary list builder
      class SummaryListTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'renders a basic nhsuk summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X', value: 'Y')
          end

          assert_select("dl.#{@brand}-summary-list")
          assert_select("div.#{@brand}-summary-list__row")
          assert_select("dt.#{@brand}-summary-list__key", text: 'X')
          assert_select("dd.#{@brand}-summary-list__value", text: 'Y')
        end

        test 'renders multiple value in a summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X') do |row|
              row.add_value('Y')
              row.add_value('Z')
            end
          end

          assert_select("dt.#{@brand}-summary-list__key", text: 'X')
          assert_select("dd.#{@brand}-summary-list__value p", text: 'Y')
          assert_select("dd.#{@brand}-summary-list__value p", text: 'Z')
        end

        test 'renders multiple actions in a summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Actions') do |row|
              row.add_value('Item')
              row.add_action('Edit', { path: '/edit' })
              row.add_action('Delete', { path: '/delete' })
            end
          end

          assert_select("dd.#{@brand}-summary-list__actions")
          assert_select("ul.#{@brand}-summary-list__actions-list")
          assert_select("li.#{@brand}-summary-list__actions-list-item a[href='/edit']", text: 'Edit')
          assert_select("li.#{@brand}-summary-list__actions-list-item a[href='/delete']", text: 'Delete')
        end

        test 'raises error when renders a mixture of items with and without actions' do
          assert_raises(ArgumentError, 'A mix of rows with and without actions is not supported for nhsuk style.') do
            ds_summary_list do |list|
              list.add_row(key: 'Item with action') do |row|
                row.add_action('Edit', { path: '/edit' })
              end
              list.add_row(key: 'Item without action')
            end
          end
        end
      end
    end
  end
end
