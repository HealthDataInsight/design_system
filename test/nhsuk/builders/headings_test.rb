require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the nhs headings builder
      class HeadingsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhs main heading' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.main_heading('Welcome!', caption: 'Caption!')
          end

          assert_select("span.#{@brand}-caption-m", text: 'Caption!')
          assert_select("h1.#{@brand}-heading-xl", text: 'Welcome!')
        end

        test 'rendering nhs default paragraph heading' do
          @output_buffer = ds_heading('Paragraph heading!', id: 'test-heading')

          assert_select("h2.#{brand}-heading-l[id='test-heading']", text: 'Paragraph heading!')
        end

        test 'rendering nhs paragraph heading with specified level' do
          @output_buffer = ds_heading('Paragraph heading!', level: 3)

          assert_select("h3.#{brand}-heading-m", text: 'Paragraph heading!')
        end
      end
    end
  end
end
