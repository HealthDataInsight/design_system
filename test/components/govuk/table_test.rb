require 'test_helper'

module DesignSystem
  module Components
    module Govuk
      # This tests the govuk headings component
      class TableTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk table' do
          @output_buffer = design_system do |ds|
            ds.table do |table|
              table.caption = 'X and Y'
              table.add_column_heading 'X'
            end
          end

          assert_select("table.#{@brand}-table")
          assert_select("caption.#{@brand}-table__caption", text: 'X and Y')
          assert_select("th.#{@brand}-table__header", text: 'X')
        end
      end
    end
  end
end
