require 'test_helper'
require 'will_paginate/array'

module DesignSystem
  module Govuk
    module Builders
      # This tests the govuk pagination renderer
      class PaginationRendererTest < ActionView::TestCase
        include DesignSystemHelper
        include WillPaginate::ActionView

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
          WillPaginate::ActionView::LinkRenderer.any_instance.stubs(:url).returns('/?brand=govuk&page=1')
        end

        test 'rendering govuk pagination' do
          assistants = [
            Assistant.new(title: '1'),
            Assistant.new(title: '2')
          ]

          # Paginate the array
          @assistants = assistants.paginate(page: params[:page], per_page: 1)

          @output_buffer = ds_pagination(@assistants)

          assert_select('nav.govuk-pagination') do
            assert_select('li.govuk-pagination__item.govuk-pagination__item--current') do
              assert_select('a.govuk-link.govuk-pagination__link[aria-current="page"][aria-label="Page 1"]') do
                1
              end
            end
            assert_select('li.govuk-pagination__item') do
              assert_select('a.govuk-link.govuk-pagination__link[aria-label="Page 2"]') do
                2
              end
            end
          end
        end

        test 'rendering govuk pagination previous page link' do
          assistants = [
            Assistant.new(title: '1'),
            Assistant.new(title: '2')
          ]

          # Paginate the array
          @assistants = assistants.paginate(page: 2, per_page: 1)

          @output_buffer = ds_pagination(@assistants)

          assert_select('nav.govuk-pagination') do
            assert_select('div.govuk-pagination__prev', count: 1) do
              assert_select('a.govuk-link.govuk-pagination__link') do
                assert_select('svg.govuk-pagination__icon.govuk-pagination__icon--prev')
                assert_select('span.govuk-pagination__link-title', html: <<~HTML.squish)
                  Previous<span class="govuk-visually-hidden">page</span>
                HTML
              end
            end
          end
        end

        test 'rendering govuk pagination has no previous page link on first page' do
          assistants = [
            Assistant.new(title: '1'),
            Assistant.new(title: '2')
          ]

          # Paginate the array
          @assistants = assistants.paginate(page: 1, per_page: 1)

          @output_buffer = ds_pagination(@assistants)

          assert_select('nav.govuk-pagination') do
            assert_select('div.govuk-pagination__prev', count: 0)
          end
        end

        test 'rendering govuk pagination next page link' do
          assistants = [
            Assistant.new(title: '1'),
            Assistant.new(title: '2')
          ]

          # Paginate the array
          @assistants = assistants.paginate(page: 1, per_page: 1)

          @output_buffer = ds_pagination(@assistants)

          assert_select('nav.govuk-pagination') do
            assert_select('div.govuk-pagination__next', count: 1) do
              assert_select('a.govuk-link.govuk-pagination__link') do
                assert_select('span.govuk-pagination__link-title', html: <<~HTML.squish)
                  Next<span class="govuk-visually-hidden">page</span>
                HTML
                assert_select('svg.govuk-pagination__icon.govuk-pagination__icon--next')
              end
            end
          end
        end

        test 'rendering govuk pagination has no next page link on last page' do
          assistants = [
            Assistant.new(title: '1'),
            Assistant.new(title: '2')
          ]

          # Paginate the array
          @assistants = assistants.paginate(page: 2, per_page: 1)

          @output_buffer = ds_pagination(@assistants)

          assert_select('nav.govuk-pagination') do
            assert_select('div.govuk-pagination__next', count: 0)
          end
        end

        test 'rendering govuk pagination gap as an ellipses list item inside the list' do
          assistants = (1..25).map { |n| Assistant.new(title: n.to_s) }

          # Enough pages to force will_paginate to render a gap
          @assistants = assistants.paginate(page: 1, per_page: 1)

          @output_buffer = ds_pagination(@assistants)

          assert_select('nav.govuk-pagination') do
            assert_select('ul.govuk-pagination__list') do
              # The gap must be a list item, not a bare <span class="gap">
              assert_select('li.govuk-pagination__item.govuk-pagination__item--ellipses', count: 1)
              assert_select('span.gap', count: 0)
            end
          end
        end
      end
    end
  end
end
