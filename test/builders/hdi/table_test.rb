require 'test_helper'

module DesignSystem
  module Builders
    module Hdi
      # This tests the hdi table builder
      class TableTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi table' do
          @output_buffer = ds_table do |table|
            table.caption = 'X and Y'
            table.add_column('X')
          end

          assert_select 'table' do
            assert_select 'caption'
            assert_select 'thead' do
              assert_select 'tr' do
                assert_select 'th:nth-child(1)', 'X'
              end
            end
          end

          assert_select('caption.caption_top', text: 'X and Y')
        end

        test 'rendering hdi header cell with block and options' do
          @output_buffer = ds_table do |table|
            table.add_column('X')
            table.add_column('Y')
            table.add_row do |row|
              row.add_cell do
                content_tag(:span, 'Bold Text', class: 'bold')
              end
              row.add_cell({ type: 'numeric' }) do
                content_tag(:p, 5, class: 'foo')
              end
            end
          end

          assert_select 'table' do
            assert_select 'tbody' do
              assert_select 'tr' do
                assert_select 'td' do
                  assert_select 'span.bold', text: 'Bold Text'
                end
                assert_select 'td[type="numeric"]' do
                  assert_select 'p.foo', text: '5'
                end
              end
            end
          end
        end

        test 'rendering hdi header cell with content' do
          @output_buffer = ds_table do |table|
            table.add_column('X')
            table.add_column('Y')
            table.add_row do |row|
              row.add_cell(
                content_tag(:span, 'Bold Text', class: 'bold')
              )
              row.add_cell(
                content_tag(:p, 5, class: 'foo'),
                { type: 'numeric' }
              )
            end
          end

          assert_select 'table' do
            assert_select 'tbody' do
              assert_select 'tr' do
                assert_select 'td' do
                  assert_select 'span.bold', text: 'Bold Text'
                end
                assert_select 'td[type="numeric"]' do
                  assert_select 'p.foo', text: '5'
                end
              end
            end
          end
        end

        test 'rendering hdi table with too many cells' do
          assert_raise ArgumentError, 'Too many cells in row (expected at most 1, got 2)' do
            ds_table do |table|
              table.add_column('X')
              table.add_row do |row|
                row.add_cell('A')
                row.add_cell('B')
              end
            end
          end
        end
      end
    end
  end
end
