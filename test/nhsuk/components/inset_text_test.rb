# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk inset text component
      class InsetTextTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'renders nothing without content' do
          @output_buffer = ds_inset_text

          assert_select 'div.nhsuk-inset-text', count: 0
        end

        test 'rendering nhsuk inset text with text parameter' do
          @output_buffer = ds_inset_text('You can report any suspected side effect using the Yellow Card safety scheme.')

          assert_select 'div.nhsuk-inset-text' do
            assert_select 'span.nhsuk-u-visually-hidden', text: /Information:/
            assert_select 'p', 'You can report any suspected side effect using the Yellow Card safety scheme.'
          end
        end

        test 'rendering nhsuk inset text with html options' do
          @output_buffer = ds_inset_text('Test content', id: 'test-id', class: 'custom-class')

          assert_select 'div.nhsuk-inset-text.custom-class#test-id' do
            assert_select 'span.nhsuk-u-visually-hidden', text: /Information:/
            assert_select 'p', 'Test content'
          end
        end

        test 'rendering nhsuk inset text with block' do
          @output_buffer = ds_inset_text do
            'You can report any suspected side effect using the Yellow Card safety scheme.'
          end

          assert_select 'div.nhsuk-inset-text' do
            assert_select 'span.nhsuk-u-visually-hidden', text: /Information:/
          end
          assert_select 'div.nhsuk-inset-text',
                        text: /You can report any suspected side effect using the Yellow Card safety scheme/
        end

        test 'blank block does not fall back to text' do
          @output_buffer = ds_inset_text('Fallback text') { '' }

          assert_select 'div.nhsuk-inset-text', count: 0
        end
      end
    end
  end
end
