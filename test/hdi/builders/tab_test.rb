# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Hdi
    module Builders
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

          assert_select 'div.hdi-tabs[data-controller="tabs"]' do
            assert_select 'ul.hdi-tabs__list' do
              assert_select 'li.hdi-tabs__list-item' do
                assert_select 'button.hdi-tabs__tab.hdi-tabs__tab--selected[data-tabs-target="tabButton"]', 'Test'
              end
            end
          end

          assert_select('div.hdi-tabs__panel[data-tabs-target="tabPanel"]', text: 'trial paragraph')
        end
      end
    end
  end
end
