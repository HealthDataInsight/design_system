require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk paragraph builder
      class ParagraphTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk normal paragraph' do
          @output_buffer = ds_paragraph('This is a normal paragraph')

          assert_select("p.#{@brand}-body", text: 'This is a normal paragraph')
        end

        test 'rendering govuk default paragraph heading' do
          @output_buffer = ds_paragraph('This is a small paragraph', size: :s)

          assert_select("p.#{@brand}-body-s", text: 'This is a small paragraph')
        end

        test 'rendering govuk paragraph with invalid size' do
          assert_raises(ArgumentError) do
            ds_paragraph('This is a paragraph', size: :m)
          end
        end

        test 'rendering govuk lead paragraph' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.lead_paragraph('This is a lead paragraph')
          end

          assert_select("p.#{@brand}-body-l", text: 'This is a lead paragraph')
        end

        test 'rendering multiple govuk lead paragraphs' do
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
