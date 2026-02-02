# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the nhsuk back link builder
      class BacklinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering nhsuk backlink only, no label' do
          ds_fixed_elements do |ds|
            ds.backlink nil, assistant_path(@assistant)
          end

          @output_buffer = @view_flow.get(:backlink)
          assert_select("a.#{@brand}-back-link", href: assistant_path(@assistant), text: 'Back')
        end

        test 'rendering nhsuk backlink only, with label' do
          ds_fixed_elements do |ds|
            ds.backlink 'Custom text', assistant_path(@assistant)
          end

          @output_buffer = @view_flow.get(:backlink)
          assert_select("a.#{@brand}-back-link", href: assistant_path(@assistant), text: 'Custom text')
        end

        test 'rendering nhsuk backlink with breadcrumbs' do
          ds_fixed_elements do |ds|
            ds.breadcrumb 'One', root_path
            ds.backlink 'Custom text', assistant_path(@assistant)
          end

          # backlink should not coexist with breadcrumbs
          @output_buffer = @view_flow.get(:breadcrumbs)
          assert_select("nav.#{@brand}-breadcrumb") do
            assert_select("ol.#{@brand}-breadcrumb__list") do
              assert_select("li.#{@brand}-breadcrumb__list-item") do
                assert_select("a.#{@brand}-breadcrumb__link", href: root_url, text: 'One')
              end
            end
          end
          @output_buffer = @view_flow.get(:backlink)
          assert_select("a.#{@brand}-back-link", false)
        end
      end
    end
  end
end
