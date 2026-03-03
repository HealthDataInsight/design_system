require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      class ListTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'renders a basic govuk list with items' do
          @output_buffer = ds_list do |list|
            list.add_item('Item 1')
            list.add_item('Item 2')
          end

          assert_select("ul.#{@brand}-list") do
            assert_select 'li', text: 'Item 1'
            assert_select 'li', text: 'Item 2'
          end
        end

        test 'renders a govuk list with bullet style' do
          @output_buffer = ds_list(type: :bullet) do |list|
            list.add_item('Bullet 1')
          end

          assert_select("ul.#{@brand}-list.#{@brand}-list--bullet") do
            assert_select 'li', text: 'Bullet 1'
          end
        end

        test 'renders a govuk list with block items' do
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

