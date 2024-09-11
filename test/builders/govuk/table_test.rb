require 'test_helper'

module DesignSystem
  module Builders
    module Govuk
      # This tests the govuk headings builder
      class TableTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk table' do
          @output_buffer = ds_table do |table|
            table.caption = 'X and Y'
            table.add_column('X')
          end

          assert_select("table.#{@brand}-table")
          assert_select("caption.#{@brand}-table__caption", text: 'X and Y')
          assert_select("th.#{@brand}-table__header", text: 'X')
        end
      end
    end
  end
end
