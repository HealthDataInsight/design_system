# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Builders
      class DetailsTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'renders govuk details with summary and block content' do
          @output_buffer = ds_details('How to find your NHS number') do
            content_tag(:p, 'Example details text')
          end

          assert_select 'details.govuk-details' do
            assert_select 'summary.govuk-details__summary' do
              assert_select 'span.govuk-details__summary-text', text: 'How to find your NHS number'
            end
            assert_select 'div.govuk-details__text' do
              assert_select 'p', text: 'Example details text'
            end
          end
        end
      end
    end
  end
end
