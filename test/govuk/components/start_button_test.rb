# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Components
      # This tests the govuk start button component
      class StartButtonTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk start button' do
          @output_buffer = ds_start_button('Start', '/start')

          assert_select('a.govuk-button.govuk-button--start', href: '/start')
          assert_select('a svg', 1)
        end
      end
    end
  end
end
