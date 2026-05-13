# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk button builder
      class ButtonTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk button' do
          @output_buffer = ds_button_tag('Cancel', style: 'secondary')

          assert_select('button.govuk-button.govuk-button--secondary', text: 'Cancel')
        end
      end
    end
  end
end
