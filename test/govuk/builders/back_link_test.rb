# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk back link builder
      class BackLinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering govuk link' do
          @output_buffer = ds_back_link(assistant_path(@assistant))

          assert_select("a.#{@brand}-back-link", href: assistant_path(@assistant), text: 'Back')
        end

        test 'rendering govuk button link and custom text' do
          @output_buffer = ds_back_link(assistants_path, 'Custom text')

          assert_select("a.#{@brand}-back-link", href: assistants_path, text: 'Custom text')
        end
      end
    end
  end
end
