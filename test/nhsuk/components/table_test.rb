# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # Asserts NHS UK responsive table markup.
      class TableTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('nhsuk')
        end

        test 'rendering nhsuk responsive table structure with caption and column headers' do
          @output_buffer = ds_table do |table|
            table.caption = 'Skin symptoms and possible causes'
            table.add_column('Skin symptoms')
            table.add_column('Possible cause')
            table.add_row('Blisters on lips or around the mouth', 'Cold sores')
          end

          assert_select('table.nhsuk-table-responsive[role="table"]') do
            assert_select('caption.nhsuk-table__caption', text: 'Skin symptoms and possible causes')

            assert_select('thead.nhsuk-table__head[role="rowgroup"]') do
              assert_select('tr.nhsuk-table__row[role="row"]') do
                assert_select('th.nhsuk-table__header[scope="col"][role="columnheader"]',
                              text: 'Skin symptoms')
                assert_select('th.nhsuk-table__header[scope="col"][role="columnheader"]',
                              text: 'Possible cause')
              end
            end

            assert_select('tbody.nhsuk-table__body') do
              assert_select('tr.nhsuk-table__row[role="row"]') do
                assert_select('th.nhsuk-table__header[scope="row"][role="rowheader"]',
                              text: /Blisters on lips or around the mouth/) do
                  assert_select('span.nhsuk-table-responsive__heading[aria-hidden="true"]',
                                text: 'Skin symptoms')
                end
                assert_select('td.nhsuk-table__cell[role="cell"]', text: /Cold sores/) do
                  assert_select('span.nhsuk-table-responsive__heading[aria-hidden="true"]',
                                text: 'Possible cause')
                end
              end
            end
          end
        end

        test 'rendering nhsuk numeric columns with numeric modifiers' do
          @output_buffer = ds_table do |table|
            table.caption = 'Ibuprofen liquid dosages for children'
            table.add_column('Age')
            table.add_numeric_column('How much?')
            table.add_numeric_column('How often?')
            table.add_row('3 to 5 months', '2.5ml', 'Max 3 times in 24 hours')
          end

          assert_select('thead.nhsuk-table__head') do
            assert_select('th.nhsuk-table__header[scope="col"]', text: 'Age')
            assert_select('th.nhsuk-table__header.nhsuk-table__header--numeric[scope="col"]',
                          text: 'How much?')
            assert_select('th.nhsuk-table__header.nhsuk-table__header--numeric[scope="col"]',
                          text: 'How often?')
          end

          assert_select('tbody.nhsuk-table__body tr.nhsuk-table__row') do
            assert_select('th.nhsuk-table__header[scope="row"][role="rowheader"]', text: /3 to 5 months/)
            assert_select('td.nhsuk-table__cell.nhsuk-table__cell--numeric[role="cell"]', text: /2.5ml/)
            assert_select('td.nhsuk-table__cell.nhsuk-table__cell--numeric[role="cell"]',
                          text: /Max 3 times in 24 hours/)
          end
          assert_select('[type="numeric"]', count: 0)
        end

        test 'rendering nhsuk cells with block content and responsive headings' do
          @output_buffer = ds_table do |table|
            table.add_column('Name')
            table.add_column('Notes')
            table.add_row do |row|
              row.add_cell { content_tag(:span, 'Bold Text', class: 'bold') }
              row.add_cell { content_tag(:p, 'Normal Text', class: 'normal') }
            end
          end

          assert_select('tbody.nhsuk-table__body tr.nhsuk-table__row') do
            assert_select('th.nhsuk-table__header[scope="row"][role="rowheader"]') do
              assert_select('span.nhsuk-table-responsive__heading[aria-hidden="true"]', text: 'Name')
              assert_select('span.bold', text: 'Bold Text')
            end
            assert_select('td.nhsuk-table__cell[role="cell"]') do
              assert_select('span.nhsuk-table-responsive__heading[aria-hidden="true"]', text: 'Notes')
              assert_select('p.normal', text: 'Normal Text')
            end
          end
        end

        test 'rendering nhsuk cells with html options' do
          @output_buffer = ds_table do |table|
            table.add_column('Name')
            table.add_column('Notes')
            table.add_row do |row|
              row.add_cell('Alice')
              row.add_cell('Extra', { id: 'notes-cell' })
            end
          end

          assert_select('td.nhsuk-table__cell#notes-cell[role="cell"]', text: /Extra/)
        end
      end
    end
  end
end
