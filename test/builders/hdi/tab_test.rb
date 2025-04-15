# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Hdi
      # This tests the hdi tabs builder
      class TabTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering hdi table' do
          @output_buffer = ds_tab do |tab|
            tab.add_tab_panel('Test', 'test paragraph', 'test', sel: true)
            tab.add_tab_panel('Trial', 'trial paragraph', 'trial')
          end

          assert_select 'div.hdi-tabs' do
            assert_select 'ul.hdi-tabs__list' do
              assert_select 'li.hdi-tabs__list-item' do
                assert_select 'button#test-tab', 'Test'
              end
            end
          end

          assert_select('div#trial p', text: 'trial paragraph')
        end
      end
    end
  end
end
