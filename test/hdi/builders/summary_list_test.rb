require 'test_helper'

module DesignSystem
  module Hdi
    module Builders
      # This tests the hdi summary list builder
      class SummaryListTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'renders a basic summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X', value: 'Y')
          end

          assert_select("dl.#{@brand}-summary-list")
          assert_select("div.#{@brand}-summary-list__row")
          assert_select("dt.#{@brand}-summary-list__key", text: 'X')
          assert_select("dd.#{@brand}-summary-list__value", text: 'Y')
        end

        test 'renders multiple values in a summary list' do
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

        test 'renders actions in a summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Actions', value: 'Item') do |row|
              row.add_action('Edit', path: '/edit')
              row.add_action('Delete', path: '/delete')
            end
          end

          assert_select("dd.#{@brand}-summary-list__value")
          assert_select("ul.#{@brand}-summary-list__actions-list")
          assert_select("li.#{@brand}-summary-list__actions-list-item a[href='/edit']", text: 'Edit')
          assert_select("li.#{@brand}-summary-list__actions-list-item a[href='/delete']", text: 'Delete')
        end

        test 'renders row with correct spacing for multiple actions' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X') do |row|
              row.add_action('1', path: '/1')
              row.add_action('2', path: '/2')
              row.add_action('3', path: '/3')
            end
          end

          assert_select("li.#{@brand}-summary-list__actions-list-item a[href='/1']", text: '1')
          assert_select("li.#{@brand}-summary-list__actions-list-item a[href='/2']", text: '2')
          assert_select("li.#{@brand}-summary-list__actions-list-item a[href='/3']", text: '3')
        end
      end
    end
  end
end
