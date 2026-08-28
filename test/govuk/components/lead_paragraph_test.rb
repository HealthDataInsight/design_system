# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Components
      # This tests the govuk lead paragraph fixed element
      class LeadParagraphTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
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
