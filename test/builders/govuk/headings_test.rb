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
            ds.main_heading('Welcome!')
          end

          assert_select("h1.#{@brand}-heading-xl", text: 'Welcome!')
        end

        test 'rendering govuk subheading' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.subheading('Subheading!')
          end

          assert_select("h2.#{@brand}-heading-l", text: 'Subheading!')
        end
      end
    end
  end
end
