require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the nhsuk paragraph builder
      class ParagraphTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk normal paragraph' do
          @output_buffer = ds_paragraph('This is a normal paragraph')

          assert_select("p.#{@brand}-body", text: 'This is a normal paragraph')
        end

        test 'rendering nhsuk default paragraph heading' do
          @output_buffer = ds_paragraph('This is a small paragraph', size: :s)

          assert_select("p.#{@brand}-body-s", text: 'This is a small paragraph')
        end

        test 'rendering nhsuk paragraph with invalid size' do
          assert_raises(ArgumentError) do
            ds_paragraph('This is a paragraph', size: :m)
          end
        end

        test 'rendering nhsuk lead paragraph' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.lead_paragraph('This is a lead paragraph')
          end

          assert_select("p.#{@brand}-body-l", text: 'This is a lead paragraph')
        end

        test 'rendering multiple nhsuk lead paragraphs' do
          assert_raises(ArgumentError) do
            ds_fixed_elements do |ds|
              ds.lead_paragraph('This is a lead paragraph')
              ds.lead_paragraph('This is another lead paragraph')
            end
          end
        end
      end
    end
  end
end
