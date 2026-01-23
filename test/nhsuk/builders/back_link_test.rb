# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the nhsuk back link builder
      class BackLinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering nhsuk link' do
          @output_buffer = ds_back_link(assistant_path(@assistant))

          assert_select("div.#{@brand}-back-link") do
            assert_select("a.#{@brand}-back-link__link", href: assistant_path(@assistant), text: 'Back')
            assert_select("svg.#{@brand}-icon.#{@brand}-icon__chevron-left")
          end
        end

        test 'rendering govuk button link and custom text' do
          @output_buffer = ds_back_link(assistants_path, 'Custom text')

          assert_select("div.#{@brand}-back-link") do
            assert_select("a.#{@brand}-back-link__link", href: assistants_path, text: 'Custom text')
            assert_select("svg.#{@brand}-icon.#{@brand}-icon__chevron-left")
          end
        end
      end
    end
  end
end
