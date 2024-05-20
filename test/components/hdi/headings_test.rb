require 'test_helper'

module DesignSystem
  module Components
    module Hdi
      # This tests the hdi headings component
      class HeadingsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi main heading' do
          @output_buffer = design_system do |ds|
            ds.main_heading('Welcome!')
          end
          # TODO: decide on class-matching: class="text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl"
          assert_select('h1', text: 'Welcome!')
        end
      end
    end
  end
end
