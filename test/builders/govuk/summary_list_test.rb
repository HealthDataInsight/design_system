require 'test_helper'

module DesignSystem
  module Builders
    module Govuk
      # This tests the govuk summary list builder
      class SummaryListTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'renders a basic govuk summary list' do
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

        test 'renders a summary list with a linked value' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Website') do |row|
              row.add_value('Visit', { path: 'https://example.com' })
            end
          end

          assert_select("dd.#{@brand}-summary-list__value a.#{@brand}-link", text: 'Visit')
          assert_select("dd.#{@brand}-summary-list__value a[href='https://example.com']")
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
      end
    end
  end
end
