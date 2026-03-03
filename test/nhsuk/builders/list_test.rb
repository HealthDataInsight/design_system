require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      class ListTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'renders a basic nhsuk list with items' do
          @output_buffer = ds_list do |list|
            list.add_item('Item 1')
            list.add_item('Item 2')
          end

          assert_select("ul.#{@brand}-list") do
            assert_select 'li', text: 'Item 1'
            assert_select 'li', text: 'Item 2'
          end
        end

        test 'renders a nhsuk ordered list with number style' do
          @output_buffer = ds_list(type: :number) do |list|
            list.add_item('First')
          end

          assert_select("ol.#{@brand}-list.#{@brand}-list--number") do
            assert_select 'li', text: 'First'
          end
        end

        test 'renders a nhsuk list with block items' do
          @output_buffer = ds_list do |list|
            list.add_item do
              content_tag(:span, 'Block item', class: 'block-item')
            end
          end

          assert_select("ul.#{@brand}-list") do
            assert_select 'li span.block-item', text: 'Block item'
          end
        end
      end
    end
  end
end

