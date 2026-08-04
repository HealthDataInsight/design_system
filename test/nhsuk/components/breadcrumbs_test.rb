# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Components
      # This tests the nhsuk breadcrumbs component
      class BreadcrumbsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('nhsuk')
        end

        test 'rendering nhsuk breadcrumbs' do
          ds_fixed_elements do |ds|
            ds.breadcrumb('Home', root_path)
            ds.breadcrumb('Somewhere else', rails_health_check_path)
            ds.breadcrumb('Current page', '#')
          end

          # Breadcrumbs are placed in the content_for(:breadcrumbs) slot, so
          # point the assertion at that slot's HTML.
          @rendered = @view_flow.get(:breadcrumbs)
          assert_select("nav.nhsuk-breadcrumb[aria-label='Breadcrumb']") do
            assert_select('ol.nhsuk-breadcrumb__list') do
              assert_select('li.nhsuk-breadcrumb__list-item') do
                assert_select('a.nhsuk-breadcrumb__link', href: root_url)
              end
              assert_select('li.nhsuk-breadcrumb__list-item') do
                assert_select('a.nhsuk-breadcrumb__link', href: rails_health_check_path, text: 'Somewhere else')
              end
            end
            assert_select('a.nhsuk-back-link', href: '#') do
              assert_select('span.nhsuk-u-visually-hidden', text: 'Back to') do
                'Current page'
              end
            end
          end
        end
      end
    end
  end
end
