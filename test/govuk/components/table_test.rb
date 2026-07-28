# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Components
      # Asserts GOV.UK Design System table markup:
      # https://design-system.service.gov.uk/components/table/
      class TableTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('govuk')
        end

        test 'rendering govuk table structure with caption and column headers' do
          @output_buffer = ds_table do |table|
            table.caption = 'Months and rates'
            table.add_column('Month you apply')
            table.add_column('Rate for vehicles')
            table.add_row('January', '£95')
          end

          assert_select('table.govuk-table') do
            assert_select('caption.govuk-table__caption.govuk-table__caption--m', text: 'Months and rates')

            assert_select('thead.govuk-table__head') do
              assert_select('tr.govuk-table__row') do
                assert_select('th.govuk-table__header[scope="col"]', text: 'Month you apply')
                assert_select('th.govuk-table__header[scope="col"]', text: 'Rate for vehicles')
              end
            end

            assert_select('tbody.govuk-table__body') do
              assert_select('tr.govuk-table__row') do
                assert_select('th.govuk-table__header[scope="row"]', text: 'January')
                assert_select('td.govuk-table__cell', text: '£95')
              end
            end
          end
        end

        test 'rendering govuk numeric columns with numeric modifiers' do
          @output_buffer = ds_table do |table|
            table.caption = 'Months and rates'
            table.add_column('Month you apply')
            table.add_numeric_column('Rate for bicycles')
            table.add_numeric_column('Rate for vehicles')
            table.add_row('January', '£85', '£95')
          end

          assert_select('thead.govuk-table__head') do
            assert_select('th.govuk-table__header[scope="col"]', text: 'Month you apply')
            assert_select('th.govuk-table__header.govuk-table__header--numeric[scope="col"]',
                          text: 'Rate for bicycles')
            assert_select('th.govuk-table__header.govuk-table__header--numeric[scope="col"]',
                          text: 'Rate for vehicles')
          end

          assert_select('tbody.govuk-table__body tr.govuk-table__row') do
            assert_select('th.govuk-table__header[scope="row"]', text: 'January')
            assert_select('td.govuk-table__cell.govuk-table__cell--numeric', text: '£85')
            assert_select('td.govuk-table__cell.govuk-table__cell--numeric', text: '£95')
          end
        end

        test 'rendering govuk cells with block content' do
          @output_buffer = ds_table do |table|
            table.add_column('Name')
            table.add_column('Notes')
            table.add_numeric_column('Count')
            table.add_row do |row|
              row.add_cell { content_tag(:span, 'Bold Text', class: 'bold') }
              row.add_cell { content_tag(:p, 'Normal Text', class: 'normal') }
              row.add_cell { content_tag(:p, 5, class: 'foo') }
            end
          end

          assert_select('tbody.govuk-table__body tr.govuk-table__row') do
            assert_select('th.govuk-table__header[scope="row"] span.bold', text: 'Bold Text')
            assert_select('td.govuk-table__cell p.normal', text: 'Normal Text')
            assert_select('td.govuk-table__cell.govuk-table__cell--numeric p.foo', text: '5')
          end
        end

        test 'rendering govuk table with too many cells' do
          error = assert_raises(ArgumentError) do
            ds_table do |table|
              table.add_column('X')
              table.add_row do |row|
                row.add_cell('A')
                row.add_cell('B')
              end
            end
          end

          assert_match(/Too many cells in row/, error.message)
        end
      end
    end
  end
end
