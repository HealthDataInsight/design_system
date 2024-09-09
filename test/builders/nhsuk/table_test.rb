require 'test_helper'

module DesignSystem
  module Builders
    module Nhsuk
      # This tests the govuk headings builder
      class TableTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk table' do
          @output_buffer = design_system do |ds|
            ds.table do |table|
              table.caption = 'X and Y'
              table.add_column('X')
            end
          end

          assert_select("table.#{@brand}-table")
          assert_select("caption.#{@brand}-table__caption", text: 'X and Y')
          assert_select 'th:nth-child(1)', 'X'
        end
      end
    end
  end
end
