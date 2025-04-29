# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Nhsuk
      # This tests the nhsuk link builder
      class LinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering nhsuk link' do
          @output_buffer = ds_link_to(@assistant)

          assert_select("a.#{@brand}-link", href: assistant_path(@assistant))
        end

        test 'rendering nhsuk button link' do
          @output_buffer = ds_link_to('All assistants', assistants_path, style: 'button')

          assert_select("a.#{@brand}-button", href: assistants_path)
        end

        test 'rendering nhsuk button link with options' do
          @output_buffer = ds_link_to('Edit assistants', edit_assistant_path(@assistant), method: :patch, style: 'button-secondary')

          assert_select("a.#{@brand}-button.#{@brand}-button--secondary", href: edit_assistant_path(@assistant))
        end

        test 'rendering nhsuk button link with url and block' do
          @output_buffer = ds_link_to('https://example.com', style: 'button-reverse') do
            content_tag(:span, 'Show assistant')
          end

          assert_select("a.#{@brand}-button.#{@brand}-button--reverse", href: 'https://example.com') do
            assert_select('span', text: 'Show assistant')
          end
        end

        test 'rendering nhsuk button link with active record model and block' do
          @output_buffer = ds_link_to @assistant, style: 'button-warning' do
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
