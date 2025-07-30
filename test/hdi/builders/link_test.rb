# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Hdi
    module Builders
      # This tests the hdi link builder
      class LinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering hdi link' do
          @output_buffer = ds_link_to(@assistant)

          assert_select("a.#{@brand}-link", href: assistant_path(@assistant))
        end

        test 'rendering hdi button link' do
          @output_buffer = ds_link_to('All assistants', assistants_path, type: :button)

          assert_select("a.#{@brand}-button", href: assistants_path)
        end

        test 'rendering hdi button link with options' do
          @output_buffer = ds_link_to('Edit assistants', edit_assistant_path(@assistant), method: :patch, type: :secondary_button)

          assert_select("a.#{@brand}-button.#{@brand}-button--secondary", href: edit_assistant_path(@assistant))
        end

        test 'rendering hdi button link with url and block' do
          @output_buffer = ds_link_to('https://example.com', type: :secondary_button) do
            content_tag(:span, 'Show assistant')
          end

          assert_select("a.#{@brand}-button.#{@brand}-button--secondary", href: 'https://example.com') do
            assert_select('span', text: 'Show assistant')
          end
        end

        test 'rendering hdi button link with active record model and block' do
          @output_buffer = ds_link_to @assistant, type: :warning_button do
            content_tag(:span, 'Show assistant')
          end

          assert_select("a.#{@brand}-button.#{@brand}-button--warning", href: 'https://example.com') do
            assert_select('span', text: 'Show assistant')
          end
        end
      end
    end
  end
end
