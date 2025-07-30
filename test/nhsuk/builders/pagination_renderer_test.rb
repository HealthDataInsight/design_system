require 'test_helper'
require 'will_paginate/array'

module DesignSystem
  module Nhsuk
    module Builders
      # This tests the hdi pagination renderer
      class PaginationRendererTest < ActionView::TestCase
        include DesignSystemHelper
        include WillPaginate::ActionView

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
          WillPaginate::ActionView::LinkRenderer.any_instance.stubs(:url).returns('/?brand=nhsuk&page=1')
        end

        test 'rendering nhsuk pagination' do
          assistants = [
            Assistant.new(title: '1'),
            Assistant.new(title: '2')
          ]

          # Paginate the array
          @assistants = assistants.paginate(page: params[:page], per_page: 1)

          @output_buffer = ds_pagination(@assistants)

          assert_select('nav.nhsuk-pagination') do
            assert_select('ul.nhsuk-list.nhsuk-pagination__list') do
              assert_select('li.nhsuk-pagination-item--previous') do
                'Previous'
              end
            end
          end
        end
      end
    end
  end
end
