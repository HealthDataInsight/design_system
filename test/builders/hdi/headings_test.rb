require 'test_helper'

module DesignSystem
  module Builders
    module Hdi
      # This tests the hdi headings builder
      class HeadingsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi main heading' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.main_heading('Welcome!', caption: 'Caption!')
          end

          assert_select('div') do
            assert_select("span.#{@brand}-caption-m", text: 'Caption!')
            assert_select("h1.#{@brand}-heading-xl", text: 'Welcome!')
          end
        end

        test 'rendering hdi default paragraph heading' do
          @output_buffer = ds_heading('Paragraph heading!', id: 'test-heading')

          assert_select("h2.#{@brand}-heading-l[id='test-heading']", text: 'Paragraph heading!')
        end

        test 'rendering hdi paragraph heading with specified level' do
          @output_buffer = ds_heading('Paragraph heading!', level: 3)

          assert_select("h3.#{@brand}-heading-m", text: 'Paragraph heading!')
        end

        test 'rendering paragraph heading with invalid level' do
          assert_raises ArgumentError do
            @output_buffer = ds_heading('Paragraph heading!', level: 7)
          end
        end
      end
    end
  end
end
