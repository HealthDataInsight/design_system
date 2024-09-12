# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Builders
    module Govuk
      # This tests the govuk breadcrumbs builder
      class BreadcrumbsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk breadcrumbs' do
          design_system do |ds|
            ds.breadcrumb('Home', root_path)
            ds.breadcrumb('Somewhere else', rails_health_check_path)
          end

          # Breadcrumbs are rendered with content_for(:breadcrumbs),
          # so to test the generated HTML, we need to copy it to the
          # output buffer.
          @output_buffer = @view_flow.get(:breadcrumbs)
          assert_select("div.#{@brand}-breadcrumbs") do
            assert_select("ol.#{@brand}-breadcrumbs__list", role: 'listz') do
              # Tests root_path
              assert_select("li.#{@brand}-breadcrumbs__list-item") do
                assert_select("a.#{@brand}-breadcrumbs__link", href: root_url)
              end

              assert_select("li.#{@brand}-breadcrumbs__list-item") do
                assert_select("a.#{@brand}-breadcrumbs__link", href: rails_health_check_path, text: 'Somewhere else')
              end
            end
          end
        end
      end
    end
  end
end
