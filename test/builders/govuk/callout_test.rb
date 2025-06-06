# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Govuk
      # This tests the govuk callout builder
      class CalloutTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk callout' do
          @output_buffer = ds_callout('Important Notice:', 'This is important!')

          assert_select 'div.govuk-warning-text' do
            assert_select 'span.govuk-warning-text__icon', '!'
            assert_select 'strong.govuk-warning-text__text', /Important Notice: This is important!/
          end
        end
      end
    end
  end
end
