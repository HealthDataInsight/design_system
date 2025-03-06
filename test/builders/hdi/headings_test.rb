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
            ds.main_heading('Welcome!')
          end
          # TODO: decide on class-matching: class="text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl"
          assert_select('h1', text: 'Welcome!')
        end

        test 'rendering hdi caption' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.caption('Caption!')
          end

          assert_select('span', text: 'Caption!')
        end

        test 'rendering hdi default paragraph heading' do
          @output_buffer = ds_heading('Paragraph heading!')

          assert_select('h2', text: 'Paragraph heading!')
        end

        test 'rendering hdi paragraph heading with specified level' do
          @output_buffer = ds_heading('Paragraph heading!', level: 3)

          assert_select('h3', text: 'Paragraph heading!')
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
