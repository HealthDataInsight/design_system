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
              assert_select('a.govuk-link.govuk-pagination__link') do
                1
              end
            end
          end
        end
      end
    end
  end
end
