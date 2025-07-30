# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Hdi
    module Builders
      # This tests the hdi callout builder
      class CalloutTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi callout' do
          @output_buffer = ds_callout('Important Notice:', 'This is important!')

          assert_select 'div.hdi-warning-callout' do
            assert_select 'h3.hdi-warning-callout__label', text: /Important Notice:/ do
              assert_select 'span.hdi-visually-hidden', text: 'Important:'
            end
            assert_select 'p', 'This is important!'
          end
        end
      end
    end
  end
end
