# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Nhsuk
    module Builders
      class DetailsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'nhsuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'renders nhsuk details with summary and block content' do
          @output_buffer = ds_details('How to find your NHS number') do
            content_tag(:p, 'Example details text')
          end

          assert_select 'details.nhsuk-details' do
            assert_select 'summary.nhsuk-details__summary' do
              assert_select 'span.nhsuk-details__summary-text', text: 'How to find your NHS number'
            end
            assert_select 'div.nhsuk-details__text' do
              assert_select 'p', text: 'Example details text'
            end
          end
        end
      end
    end
  end
end
