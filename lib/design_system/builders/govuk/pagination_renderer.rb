# frozen_string_literal: true

module DesignSystem
  module Builders
    module Govuk
      # This class is used to provide will_paginate renderer for Gov.UK.
      class PaginationRenderer < ::DesignSystem::Builders::Generic::PaginationRenderer
        def container_attributes
          { class: 'govuk-pagination', role: 'navigation', 'aria-label': 'Pagination' }
        end

        def html_container(html)
          tag(:nav, html, container_attributes)
        end

        def previous_or_next_page(page, text, classname)
          if classname.include?('previous_page')
            tag(:div, link_with_prev_title(text, page), class: 'govuk-pagination__prev') if page
          elsif classname.include?('next_page')
            tag(:div, link_with_next_title(text, page), class: 'govuk-pagination__next') if page
          end
        end

        private

        def link_with_prev_title(_text, target)
          tag(:a,
              govuk_icon('previous') + tag(:span,
                                           "Previous#{tag(:span, 'page', class: 'govuk-visually-hidden')}",
                                           class: 'govuk-pagination__link-title').html_safe,
              href: url(target),
              class: 'govuk-link govuk-pagination__link')
        end

        def link_with_next_title(_text, target)
          tag(:a,
              tag(:span,
                  "Next#{tag(:span, 'page', class: 'govuk-visually-hidden')}",
                  class: 'govuk-pagination__link-title') +
              govuk_icon('next'),
              href: url(target), class: 'govuk-link govuk-pagination__link')
        end

        def page_number(page)
          if page == current_page
            tag(:li,
                tag(:a, page, class: 'govuk-link govuk-pagination__link', href: '#', aria: { label: "Page #{page}", current: 'page' }), class: 'govuk-pagination__item govuk-pagination__item--current')
          else
            tag(:li,
                tag(:a, page, class: 'govuk-link govuk-pagination__link', href: url(page), aria: { label: "Page #{page}" }), class: 'govuk-pagination__item')
          end
        end

        # GOV.UK icons
        def govuk_icon(type)
          case type
          when 'previous'
            '<svg class="govuk-pagination__icon govuk-pagination__icon--prev" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewBox="0 0 15 13">
            <path d="m6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z"></path>
            </svg>'
          when 'next'
            '<svg class="govuk-pagination__icon govuk-pagination__icon--next" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewBox="0 0 15 13">
            <path d="m8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z"></path>
            </svg>'
          end
        end
      end
    end
  end
end
