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
      end
    end
  end
end
