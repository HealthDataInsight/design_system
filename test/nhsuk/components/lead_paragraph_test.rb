# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk lead paragraph fixed element
      class LeadParagraphTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
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
