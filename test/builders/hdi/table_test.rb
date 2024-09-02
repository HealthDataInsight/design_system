require 'test_helper'

module DesignSystem
  module Builders
    module Hdi
      # This tests the govuk headings builder
      class TableTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi table' do
          @output_buffer = design_system do |ds|
            ds.table do |table|
              table.caption = 'X and Y'
              table.add_header do |header|
                header.add_cell('X')
              end
            end
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
      end
    end
  end
end
