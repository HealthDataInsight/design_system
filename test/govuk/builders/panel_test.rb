# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk panel builder
      class PanelTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk panel' do
          @output_buffer = ds_panel('Important Notice', 'This is important!')

          assert_select 'div.govuk-panel.govuk-panel--confirmation' do
            assert_select 'h1.govuk-panel__title', 'Important Notice'
            assert_select 'div.govuk-panel__body', 'This is important!'
          end
        end
      end
    end
  end
end
