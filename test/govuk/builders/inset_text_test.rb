# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk inset text builder
      class InsetTextTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk inset text with text parameter' do
          @output_buffer = ds_inset_text('You can report any suspected side effect using the Yellow Card safety scheme.')

          assert_select 'div.govuk-inset-text',
                        text: /You can report any suspected side effect using the Yellow Card safety scheme/
        end

        test 'rendering govuk inset text with block' do
          @output_buffer = ds_inset_text do
            content_tag(:p, 'You can report any suspected side effect using the Yellow Card safety scheme.')
          end

          assert_select 'div.govuk-inset-text' do
            assert_select 'p', 'You can report any suspected side effect using the Yellow Card safety scheme.'
          end
        end

        test 'rendering govuk inset text with html options' do
          @output_buffer = ds_inset_text('Test content', id: 'test-id', class: 'custom-class')

          assert_select 'div.govuk-inset-text.custom-class#test-id', text: 'Test content'
        end
      end
    end
  end
end
