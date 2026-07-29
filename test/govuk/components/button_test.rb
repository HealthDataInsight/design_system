# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Components
      # This tests the govuk button component
      class ButtonTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering default govuk button' do
          @output_buffer = ds_button_tag('Continue')
          assert_select('button[class="govuk-button"]', text: 'Continue')
          assert_select('button[data-module="govuk-button"]')
          assert_select('button[type="submit"]')
        end

        test 'rendering secondary govuk button' do
          @output_buffer = ds_button_tag('Cancel', style: 'secondary')

          assert_select('button.govuk-button.govuk-button--secondary', text: 'Cancel')
          assert_select('button[data-module="govuk-button"]')
          assert_select('button[type="submit"]')
        end

        test 'rendering warning govuk button' do
          @output_buffer = ds_button_tag('Delete', style: 'warning')

          assert_select('button.govuk-button.govuk-button--warning', text: 'Delete')
          assert_select('button[data-module="govuk-button"]')
          assert_select('button[type="submit"]')
        end

        test 'rendering reverse govuk button' do
          @output_buffer = ds_button_tag('Save', style: 'reverse')

          assert_select('button.govuk-button.govuk-button--inverse', text: 'Save')
          assert_select('button[data-module="govuk-button"]')
          assert_select('button[type="submit"]')
        end

        test 'rendering disabled govuk button' do
          @output_buffer = ds_button_tag('Reset', disabled: true)

          assert_select('button.govuk-button[disabled]', text: 'Reset')
          assert_select('button[data-module="govuk-button"]')
          assert_select('button[aria-disabled="true"]')
          assert_select('button[type="submit"]')
        end
      end
    end
  end
end
