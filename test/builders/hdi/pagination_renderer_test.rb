require 'test_helper'
require 'will_paginate/array'

module DesignSystem
  module Builders
    module Hdi
      # This tests the hdi pagination renderer
      class PaginationRendererTest < ActionView::TestCase
        include DesignSystemHelper
        include WillPaginate::ActionView

        setup do
          @brand = 'hdi'
          @controller.stubs(:brand).returns(@brand)
          WillPaginate::ActionView::LinkRenderer.any_instance.stubs(:url).returns('/?brand=hdi&page=1')
        end

        test 'rendering hdi pagination' do
          assistants = [
            Assistant.new(title: '1'),
            Assistant.new(title: '2')
          ]

          # Paginate the array
          @assistants = assistants.paginate(page: params[:page], per_page: 1)

          @output_buffer = ds_pagination(@assistants)

          assert_select('nav.flex') do
            assert_select('div.-mt-px') do
              assert_select('a.inline-flex') do
                'Next'
              end
            end
          end
        end
      end
    end
  end
end
