# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk tab builder
      class TabTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk tab' do
          @output_buffer = ds_tab do |tab|
            tab.add_tab_panel('Test', 'test paragraph', 'test', sel: true)
            tab.add_tab_panel('Trial', 'trial paragraph', 'trial')
          end

          assert_select('ul.govuk-tabs__list li', 2)
          assert_select('a.govuk-tabs__tab', text: 'Test')
          assert_select('div.govuk-tabs__panel', text: 'test paragraph')
        end
      end
    end
  end
end
