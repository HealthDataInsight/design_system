require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk grid component
      class GridTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('nhsuk')
        end

        test 'should fail if width is not specified' do
          assert_raises(ArgumentError) do
            ds_grid do |grid|
              grid.add_column do
                'Test content'
              end
            end
          end
        end

        test 'should fail if given width is not supported' do
          error = assert_raises(ArgumentError) do
            ds_grid do |grid|
              grid.add_column(:nonsense_width) do
                'Test content'
              end
            end
          end
          assert_equal 'Unknown grid width: nonsense_width', error.message
        end

        test 'full width grid' do
          @output_buffer = ds_grid do |grid|
            grid.add_column(:full) do
              content_tag(:p, 'Test content')
            end
          end

          assert_select 'div.nhsuk-grid-row' do
            assert_select 'div.nhsuk-grid-column-full' do
              assert_select 'p', text: 'Test content'
            end
          end
        end

        test 'one-half width grid' do
          @output_buffer = ds_grid do |grid|
            grid.add_column(:one_half) do
              content_tag(:p, 'One-half width content')
            end
          end
          assert_select 'div.nhsuk-grid-row' do
            assert_select 'div.nhsuk-grid-column-one-half' do
              assert_select 'p', text: 'One-half width content'
            end
          end
        end

        test 'one-third width grid' do
          @output_buffer = ds_grid do |grid|
            grid.add_column(:one_third) do
              content_tag(:p, 'One-third width content')
            end
          end
          assert_select 'div.nhsuk-grid-row' do
            assert_select 'div.nhsuk-grid-column-one-third' do
              assert_select 'p', text: 'One-third width content'
            end
          end
        end

        test 'two-thirds width grid' do
          @output_buffer = ds_grid do |grid|
            grid.add_column(:two_thirds) do
              content_tag(:p, 'Two-thirds width content')
            end
          end
          assert_select 'div.nhsuk-grid-row' do
            assert_select 'div.nhsuk-grid-column-two-thirds' do
              assert_select 'p', text: 'Two-thirds width content'
            end
          end
        end

        test 'one-quarter width grid' do
          @output_buffer = ds_grid do |grid|
            grid.add_column(:one_quarter) do
              content_tag(:p, 'One-quarter width content')
            end
          end
          assert_select 'div.nhsuk-grid-row' do
            assert_select 'div.nhsuk-grid-column-one-quarter' do
              assert_select 'p', text: 'One-quarter width content'
            end
          end
        end

        test 'three-quarters width grid' do
          @output_buffer = ds_grid do |grid|
            grid.add_column(:three_quarters) do
              content_tag(:p, 'Three-quarters width content')
            end
          end
          assert_select 'div.nhsuk-grid-row' do
            assert_select 'div.nhsuk-grid-column-three-quarters' do
              assert_select 'p', text: 'Three-quarters width content'
            end
          end
        end

        test 'should render multiple columns' do
          @output_buffer = ds_grid do |grid|
            grid.add_column(:two_thirds) do
              content_tag(:p, 'Two thirds content')
            end
            grid.add_column(:one_third) do
              content_tag(:p, 'One third content')
            end
          end
          assert_select 'div.nhsuk-grid-row' do
            assert_select 'div.nhsuk-grid-column-two-thirds' do
              assert_select 'p', text: 'Two thirds content'
            end
            assert_select 'div.nhsuk-grid-column-one-third' do
              assert_select 'p', text: 'One third content'
            end
          end
        end

        test 'should raise an error if total width exceeds 100%' do
          error = assert_raises(ArgumentError) do
            ds_grid do |grid|
              grid.add_column(:two_thirds) do
                content_tag(:p, 'Two thirds content')
              end
              grid.add_column(:two_thirds) do
                content_tag(:p, 'Two thirds content')
              end
            end
          end
          assert_equal 'Total grid width exceeds 100%', error.message
        end

        test 'should render nested grid' do
          @output_buffer = ds_grid do |row|
            row.add_column(:two_thirds) do
              content_tag(:p, 'Outer two thirds content') +
                ds_grid do |inner_row|
                  inner_row.add_column(:two_thirds) do
                    content_tag(:p, 'Inner two thirds content')
                  end
                end
            end
          end

          assert_select 'div.nhsuk-grid-row' do
            assert_select 'div.nhsuk-grid-column-two-thirds' do
              assert_select 'p', text: 'Outer two thirds content'
              assert_select 'div.nhsuk-grid-row' do
                assert_select 'div.nhsuk-grid-column-two-thirds' do
                  assert_select 'p', text: 'Inner two thirds content'
                end
              end
            end
          end
        end
      end
    end
  end
end
