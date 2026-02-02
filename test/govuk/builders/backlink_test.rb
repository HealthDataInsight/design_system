# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk back link builder
      class BacklinkTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
          @assistant = assistants(:one)
        end

        test 'rendering govuk backlink only, no label' do
          ds_fixed_elements do |ds|
            ds.backlink nil, assistant_path(@assistant)
          end

          @output_buffer = @view_flow.get(:backlink)
          assert_select("a.#{@brand}-back-link", href: assistant_path(@assistant), text: 'Back')
        end

        test 'rendering govuk backlink only, with label' do
          ds_fixed_elements do |ds|
            ds.backlink 'Custom text', assistant_path(@assistant)
          end

          @output_buffer = @view_flow.get(:backlink)
          assert_select("a.#{@brand}-back-link", href: assistant_path(@assistant), text: 'Custom text')
        end

        test 'rendering govuk backlink with breadcrumbs raises error' do
          assert_raises(ArgumentError, 'Cannot use both backlink and breadcrumbs') do
            ds_fixed_elements do |ds|
              ds.breadcrumb 'One', root_path
              ds.backlink 'Custom text', assistant_path(@assistant)
            end
          end
        end
      end
    end
  end
end
