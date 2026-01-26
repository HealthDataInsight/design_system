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
          assert_select('nav') do
            assert_select("div.#{@brand}-width-container") do
              assert_select("div.#{@brand}-back-link") do
                assert_select("a.#{@brand}-back-link__link", href: assistant_path(@assistant), text: 'Back')
                assert_select("svg.#{@brand}-icon.#{@brand}-icon__chevron-left")
              end
            end
          end
        end
      end
    end
  end
end
