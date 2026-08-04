# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk fixed elements component
      class FixedElementsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering a main heading' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.main_heading 'Headings'
          end

          assert_select('h1.nhsuk-heading-xl', text: 'Headings')
        end

        test 'rendering a main heading with a caption' do
          @output_buffer = ds_fixed_elements do |ds|
            ds.main_heading 'Headings', caption: 'Typography'
          end

          assert_select('span.nhsuk-caption-m', text: 'Typography')
          assert_select('h1.nhsuk-heading-xl', text: 'Headings')
        end

        test 'using both backlink and breadcrumbs raises' do
          assert_raises(ArgumentError, 'Cannot use both backlink and breadcrumbs') do
            ds_fixed_elements do |ds|
              ds.breadcrumb 'Home', root_path
              ds.backlink 'Back', root_path
            end
          end
        end
      end
    end
  end
end
