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

        test 'renders an action with custom html options' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Definition') do |row|
              row.add_action('View definition', path: '#definition', hidden_text: 'of the cohort',
                                                target: 'data-cohort')
            end
          end

          assert_select("dd.#{@brand}-summary-list__actions a.#{@brand}-link[target='data-cohort']",
                        text: /View definition/)
        end

        test 'renders an empty action cell when actions are empty' do
          @output_buffer = ds_summary_list do |list|
            list.add_row('Age', 30)
          end

          assert_select("div.#{@brand}-summary-list__row") do
            assert_select("dt.#{@brand}-summary-list__key", text: 'Age')
            assert_select("dd.#{@brand}-summary-list__value", text: '30')
            assert_select("dd.#{@brand}-summary-list__actions", text: '')
          end
        end

        test 'renders an empty value cell when values are nil' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Age') do |row|
              row.add_action('View', { path: '/view' })
            end
          end

          assert_select("div.#{@brand}-summary-list__row") do
            assert_select("dt.#{@brand}-summary-list__key", text: 'Age')
            assert_select("dd.#{@brand}-summary-list__value", text: '')
            assert_select("dd.#{@brand}-summary-list__actions a[href='/view']", text: 'View')
          end
        end
      end
    end
  end
end
