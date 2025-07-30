require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the govuk headings builder
      class TableTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk table' do
          @output_buffer = ds_table do |table|
            table.caption = 'X and Y'
            table.add_column('X')
          end

          assert_select("table.#{@brand}-table-responsive")
          assert_select("caption.#{@brand}-table__caption", text: 'X and Y')
          assert_select 'th:nth-child(1)', 'X'
        end

        test 'rendering nhsuk cells with block and options' do
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

        test 'rendering nhsuk cells with content' do
          @output_buffer = ds_table do |table|
            table.add_column('X')
            table.add_column('Y')
            table.add_row do |row|
              row.add_cell(
                content_tag(:span, 'Bold Text', class: 'bold')
              )
              row.add_cell(
                content_tag(:p, 5, class: 'foo'),
                { id: 'foo' }
              )
            end
          end

          assert_select 'table' do
            assert_select 'tbody' do
              assert_select 'tr' do
                assert_select 'td' do
                  assert_select 'span.bold', text: 'Bold Text'
                end
                assert_select 'td[id="foo"]' do
                  assert_select 'p.foo', text: '5'
                end
              end
            end
          end
        end

        test 'rendering nhsuk cells with numbers' do
          @output_buffer = ds_table do |table|
            table.add_numeric_column('X')
            table.add_numeric_column('Y')
            table.add_row(100, (5.0 / 3).round(2))
          end

          assert_select 'table' do
            assert_select 'tbody' do
              assert_select 'tr' do
                assert_select 'td:nth-child(1)', text: 'X100'
                assert_select 'td:nth-child(2)', text: 'Y1.67'
              end
            end
          end
        end
      end
    end
  end
end
