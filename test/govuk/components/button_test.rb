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

        test 'rendering govuk button' do
          @output_buffer = ds_button_tag('Save')

          assert_select('button.govuk-button[type="submit"][name="button"]', text: 'Save')
        end

        test 'rendering govuk button with style modifier' do
          @output_buffer = ds_button_tag('Cancel', style: 'secondary')

          assert_select('button.govuk-button.govuk-button--secondary', text: 'Cancel')
        end

        test 'rendering govuk button with a block' do
          @output_buffer = ds_button_tag do
            content_tag(:span, 'Continue')
          end

          assert_select('button') do
            assert_select('span', text: 'Continue')
          end
        end
      end
    end
  end
end
