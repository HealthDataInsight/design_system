# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk tab component
      class TabTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('nhsuk')
        end

        test 'rendering nhsuk tab' do
          @output_buffer = ds_tab do |tab|
            tab.title = 'Title'
            tab.add_tab_panel('Test', 'test paragraph', 'test', selected: true)
            tab.add_tab_panel('Trial', 'trial paragraph', 'trial')
          end

          assert_select('div.nhsuk-tabs[data-module="nhsuk-tabs"]') do
            assert_select('h2.nhsuk-tabs__title', text: 'Title')
            assert_select('ul.nhsuk-tabs__list') do
              assert_select('li.nhsuk-tabs__list-item') do
                assert_select('a.nhsuk-tabs__tab[href="#test"]', text: 'Test')
              end
              assert_select('li.nhsuk-tabs__list-item') do
                assert_select('a.nhsuk-tabs__tab[href="#trial"]', text: 'Trial')
              end
            end
            assert_select('div.nhsuk-tabs__panel#test', id: 'test', text: 'test paragraph')
            assert_select('div.nhsuk-tabs__panel#trial', id: 'trial', text: 'trial paragraph')
          end
        end

        test 'rendering nhsuk tab with html' do
          @output_buffer = ds_tab do |tab|
            tab.add_tab_panel('Test', nil, 'test', selected: true) do
              tag.p('a paragraph')
            end
          end

          assert_select('div.nhsuk-tabs[data-module="nhsuk-tabs"]') do
            assert_select('ul.nhsuk-tabs__list') do
              assert_select('li.nhsuk-tabs__list-item') do
                assert_select('a.nhsuk-tabs__tab[href="#test"]', text: 'Test')
              end
            end
            assert_select('div.nhsuk-tabs__panel#test', id: 'test') do
              assert_select('p', text: 'a paragraph')
            end
          end
        end
      end
    end
  end
end
