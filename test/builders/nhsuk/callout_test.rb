# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Nhsuk
      # This tests the nhsuk callout builder
      class CalloutTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk callout' do
          @output_buffer = ds_callout('Important Notice:', 'This is important!')

          assert_select 'div.nhsuk-warning-callout' do
            assert_select 'h3.nhsuk-warning-callout__label', text: /Important Notice:/ do
              assert_select 'span.nhsuk-u-visually-hidden', text: 'Important:'
            end
            assert_select 'p', 'This is important!'
          end
        end
      end
    end
  end
end
