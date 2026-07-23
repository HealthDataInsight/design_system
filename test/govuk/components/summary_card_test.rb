# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module Govuk
    module Components
      # This tests the govuk summary card component
      class SummaryCardTest < ActionView::TestCase
        include DesignSystemHelper

        setup do
          @brand = 'govuk'
          @controller.stubs(:brand).returns(@brand)
        end

        test 'rendering govuk summary card with title, actions and content' do
          @output_buffer = ds_summary_card(
            title: 'University of Gloucestershire',
            actions: [
              { text: 'Delete choice', href: '#', hidden_text: ' (University of Gloucestershire)' },
              { text: 'Withdraw', href: '#', hidden_text: ' (University of Gloucestershire)' }
            ]
          ) do
            ds_summary_list do |list|
              list.add_row('Course', 'English (3DMD)')
            end
          end

          assert_select 'div.govuk-summary-card' do
            assert_select 'div.govuk-summary-card__title-wrapper' do
              assert_select 'h2.govuk-summary-card__title', 'University of Gloucestershire'
              assert_select 'ul.govuk-summary-card__actions' do
                assert_select 'li.govuk-summary-card__action', count: 2
                assert_select 'li.govuk-summary-card__action a.govuk-link', text: /Delete choice/
                assert_select 'li.govuk-summary-card__action a.govuk-link span.govuk-visually-hidden',
                              text: '(University of Gloucestershire)'
              end
            end
            assert_select 'div.govuk-summary-card__content dl.govuk-summary-list'
          end
        end

        test 'rendering govuk summary card without actions omits the list' do
          @output_buffer = ds_summary_card(title: 'No actions') { 'Body' }

          assert_select 'div.govuk-summary-card' do
            assert_select 'h2.govuk-summary-card__title', 'No actions'
            assert_select 'ul.govuk-summary-card__actions', count: 0
            assert_select 'div.govuk-summary-card__content', text: /Body/
          end
        end
      end
    end
  end
end
