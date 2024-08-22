require 'test_helper'

module DesignSystem
  module Builders
    module Nhsuk
      # This tests the nhs headings component
      class HeadingsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhs main heading' do
          @output_buffer = design_system do |ds|
            ds.main_heading('Welcome!')
          end

          assert_select("h1.#{@brand}-heading-xl", text: 'Welcome!')
        end
      end
    end
  end
end
