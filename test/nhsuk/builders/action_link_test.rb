# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the nhsuk action link builder
      class ActionLinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering nhsuk action link' do
          @output_buffer = ds_action_link('Find your nearest A&E', assistant_path(@assistant))

          assert_select("a.#{@brand}-action-link", href: assistant_path(@assistant)) do
            assert_select("svg.#{@brand}-icon")
            assert_select("span.#{@brand}-action-link__text", text: 'Find your nearest A&E')
          end
        end
      end
    end
  end
end
