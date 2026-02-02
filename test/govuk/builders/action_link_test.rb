# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk action link builder
      class ActionLinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering govuk action link' do
          @output_buffer = ds_action_link('Find your nearest A&E', assistant_path(@assistant))

          assert_select("a.#{@brand}-button", href: assistant_path(@assistant), text: 'Find your nearest A&E')
        end
      end
    end
  end
end
