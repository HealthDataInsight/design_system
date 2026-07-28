# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk button component
      class ButtonTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering default nhsuk button' do
          @output_buffer = ds_button_tag('Continue')
          assert_select('button[class="nhsuk-button"]', text: 'Continue')
          assert_select('button[data-module="nhsuk-button"]')
          assert_select('button[type="submit"]')
        end

        test 'rendering secondary nhsuk button' do
          @output_buffer = ds_button_tag('Cancel', style: 'secondary')

          assert_select('button.nhsuk-button.nhsuk-button--secondary', text: 'Cancel')
          assert_select('button[data-module="nhsuk-button"]')
          assert_select('button[type="submit"]')
        end

        test 'rendering warning nhsuk button' do
          @output_buffer = ds_button_tag('Delete', style: 'warning')

          assert_select('button.nhsuk-button.nhsuk-button--warning', text: 'Delete')
          assert_select('button[data-module="nhsuk-button"]')
          assert_select('button[type="submit"]')
        end

        test 'rendering reverse nhsuk button' do
          @output_buffer = ds_button_tag('Save', style: 'reverse')

          assert_select('button.nhsuk-button.nhsuk-button--inverse', text: 'Save')
          assert_select('button[data-module="nhsuk-button"]')
          assert_select('button[type="submit"]')
        end

        test 'rendering disabled nhsuk button' do
          @output_buffer = ds_button_tag('Reset', disabled: true)

          assert_select('button.nhsuk-button[disabled]', text: 'Reset')
          assert_select('button[data-module="nhsuk-button"]')
          assert_select('button[aria-disabled="true"]')
          assert_select('button[type="submit"]')
        end
      end
    end
  end
end
