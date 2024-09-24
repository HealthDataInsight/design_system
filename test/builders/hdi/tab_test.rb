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

          assert_select 'div' do
            assert_select 'ul.flex.flex-wrap.-mb-px.text-sm.font-medium.text-center' do
              assert_select 'li.me-2' do
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
