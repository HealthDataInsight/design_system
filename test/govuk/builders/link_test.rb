# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk link builder
      class LinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering govuk link' do
          @output_buffer = ds_link_to(@assistant)

          assert_select("a.#{@brand}-link", href: assistant_path(@assistant))
        end

        test 'rendering govuk button link' do
          @output_buffer = ds_link_to('All assistants', assistants_path, type: :button)

          assert_select("a.#{@brand}-button", href: assistants_path)
        end

        test 'rendering govuk button link with options' do
          @output_buffer = ds_link_to('Edit assistants', edit_assistant_path(@assistant), method: :patch, type: :secondary_button)

          assert_select("a.#{@brand}-button.#{@brand}-button--secondary", href: edit_assistant_path(@assistant))
        end

        test 'rendering govuk button link with url and block' do
          @output_buffer = ds_link_to('https://example.com', type: :reverse_button) do
            content_tag(:span, 'Show assistant')
          end

          assert_select("a.#{@brand}-button.#{@brand}-button--inverse", href: 'https://example.com') do
            assert_select('span', text: 'Show assistant')
          end
        end

        test 'rendering govuk button link with active record model and block' do
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
