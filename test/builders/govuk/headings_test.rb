require 'test_helper'

module DesignSystem
  module Builders
    module Govuk
      # This tests the govuk headings builder
      class HeadingsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk main heading' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.main_heading('Welcome!', caption: 'Caption!')
          end

          assert_select('div') do
            assert_select("span.#{@brand}-caption-m", text: 'Caption!')
            assert_select("h1.#{@brand}-heading-xl", text: 'Welcome!')
          end
        end

        test 'rendering govuk default paragraph heading' do
          @output_buffer = ds_heading('Paragraph heading!')

          assert_select("h2.#{brand}-heading-l", text: 'Paragraph heading!')
        end

        test 'rendering govuk paragraph heading with specified level' do
          @output_buffer = ds_heading('Paragraph heading!', level: 3)

          assert_select("h3.#{brand}-heading-m", text: 'Paragraph heading!')
        end
      end
    end
  end
end
