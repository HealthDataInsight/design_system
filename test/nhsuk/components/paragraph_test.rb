# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk paragraph component
      class ParagraphTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering nhsuk normal paragraph' do
          @output_buffer = ds_paragraph('This is a normal paragraph')

          assert_select("p.#{@brand}-body", text: 'This is a normal paragraph')
        end

        test 'rendering nhsuk small paragraph' do
          @output_buffer = ds_paragraph('This is a small paragraph', size: :s)

          assert_select("p.#{@brand}-body-s", text: 'This is a small paragraph')
        end

        test 'rendering nhsuk paragraph with a block' do
          @output_buffer = ds_paragraph { 'Block paragraph' }

          assert_select("p.#{@brand}-body", text: 'Block paragraph')
        end

        test 'rendering nhsuk paragraph with invalid size' do
          assert_raises(ArgumentError) do
            @output_buffer = ds_paragraph('This is a paragraph', size: :m)
          end
        end

        test 'renders nothing without content' do
          @output_buffer = ds_paragraph

          assert_select("p.#{@brand}-body", count: 0)
        end
      end
    end
  end
end
