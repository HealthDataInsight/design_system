# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Components
      # This tests the govuk alert component
      class AlertTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('govuk')
        end

        test 'rendering govuk alert' do
          @output_buffer = ds_alert('Test alert!')

          assert_select 'div.govuk-error-summary' do
            assert_select 'h2.govuk-error-summary__title', 'Test alert!'
          end
        end
      end
    end
  end
end
