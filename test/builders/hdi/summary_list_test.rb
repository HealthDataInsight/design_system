require 'test_helper'

module DesignSystem
  module Builders
    module Hdi
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

          assert_select('dl.py-4.min-w-full.divide-y.divide-gray-300.overflow-hidden')
          assert_select('div.flex-wrap.px-3.py-4.sm\\:grid.sm\\:grid-cols-3.sm\\:gap-3.sm\\:px-6')
          assert_select('dt.text-sm.font-semibold.text-gray-900.flex.items-center', text: 'X')
          assert_select('dd.whitespace-nowrap.text-sm.text-gray-500.sm\\:mt-0', text: 'Y')
        end

        test 'renders multiple values in a summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X') do |row|
              row.add_value('Y')
              row.add_value('Z')
            end
          end

          assert_select('dt.text-sm.font-semibold.text-gray-900.flex.items-center', text: 'X')
          assert_select('dd.whitespace-nowrap.text-sm.text-gray-500.sm\\:mt-0 p', text: 'Y')
          assert_select('dd.whitespace-nowrap.text-sm.text-gray-500.sm\\:mt-0 p', text: 'Z')
        end

        test 'renders actions in a summary list' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'Actions', value: 'Item') do |row|
              row.add_action('Edit', path: '/edit')
              row.add_action('Delete', path: '/delete')
            end
          end

          assert_select('dd.flex.flex-wrap.justify-between.items-center.sm\\:justify-end')
          assert_select('ul.flex.flex-wrap.items-center.gap-2.sm\\:gap-1')
          assert_select("li.inline-block a[href='/edit']", text: 'Edit')
          assert_select("li.inline-block a[href='/delete']", text: 'Delete')
        end

        test 'renders row with correct spacing for multiple actions' do
          @output_buffer = ds_summary_list do |list|
            list.add_row(key: 'X') do |row|
              row.add_action('1', path: '/1')
              row.add_action('2', path: '/2')
              row.add_action('3', path: '/3')
            end
          end

          assert_select("li.inline-block.pr-2.border-r.border-gray-300 a[href='/1']", text: '1')
          assert_select("li.inline-block.px-2.border-r.border-gray-300 a[href='/2']", text: '2')
          assert_select("li.inline-block.pl-2 a[href='/3']", text: '3')
        end
      end
    end
  end
end
