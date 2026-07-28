# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Components
      # This tests the govuk breadcrumbs component
      class BreadcrumbsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @controller.stubs(:brand).returns('govuk')
        end

        test 'rendering govuk breadcrumbs' do
          ds_fixed_elements do |ds|
            ds.breadcrumb('Home', root_path)
            ds.breadcrumb('Somewhere else', rails_health_check_path)
          end

          # Breadcrumbs are rendered with content_for(:breadcrumbs),
          # so to test the generated HTML, we need to copy it to the
          # output buffer.
          @output_buffer = @view_flow.get(:breadcrumbs)
          assert_select("nav.govuk-breadcrumbs[aria-label='Breadcrumb']") do
            assert_select("ol.govuk-breadcrumbs__list") do
              assert_select("li.govuk-breadcrumbs__list-item") do
                assert_select("a.govuk-breadcrumbs__link", href: root_url)
              end
              assert_select("li.govuk-breadcrumbs__list-item") do
                assert_select("a.govuk-breadcrumbs__link", href: rails_health_check_path, text: 'Somewhere else')
              end
            end
          end
        end
      end
    end
  end
end
