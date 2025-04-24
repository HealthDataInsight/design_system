# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class is used to provide will_paginate renderer for HDI.
      class PaginationRenderer < ::DesignSystem::Builders::Generic::PaginationRenderer
        def html_container(html)
          tag(:nav, html, class: "#{brand}-pagination")
        end

        def previous_or_next_page(page, _text, classname)
          if classname.include?('previous_page')
            tag(:div, link_with_prev_title(page), class: "#{brand}-pagination-item--previous-container") if page
          elsif classname.include?('next_page')
            tag(:div, link_with_next_title(page), class: "#{brand}-pagination-item--next-container") if page
          end
        end

        private

        def link_with_prev_title(target)
          tag(:a, "Previous#{icon('previous')}",
              href: url(target),
              class: "#{brand}-pagination-item #{brand}-pagination-item--previous")
        end

        def link_with_next_title(target)
          tag(:a, "Next#{icon('next')}",
              href: url(target),
              class: "#{brand}-pagination-item #{brand}-pagination-item--next")
        end

        def page_number(page)
          if page == current_page
            tag(:a, page,
                class: "#{brand}-pagination-item #{brand}-pagination-item--active",
                href: '#', aria: { current: 'page' })
          else
            tag(:a, page,
                class: "#{brand}-pagination-item",
                href: url(page))
          end
        end

        # Tailwind icons
        def icon(type)
          case type
          when 'previous'
            %(
            <svg class="#{brand}-icon" viewBox="0 0 20 20" fill="currentColor"
            aria-hidden="true" data-slot="icon">
              <path fill-rule="evenodd" d="M18 10a.75.75 0 0 1-.75.75H4.66l2.1 1.95a.75.75 0 1 1-1.02 1.1l-3.5-3.25a.75.75
              0 0 1 0-1.1l3.5-3.25a.75.75 0 1 1 1.02 1.1l-2.1 1.95h12.59A.75.75 0 0 1 18 10Z" clip-rule="evenodd" />
            </svg>
            )
          when 'next'
            %(
            <svg class="#{brand}-icon" viewBox="0 0 20 20" fill="currentColor"
            aria-hidden="true" data-slot="icon">
              <path fill-rule="evenodd" d="M2 10a.75.75 0 0 1 .75-.75h12.59l-2.1-1.95a.75.75 0 1 1 1.02-1.1l3.5 3.25a.75.75
              0 0 1 0 1.1l-3.5 3.25a.75.75 0 1 1-1.02-1.1l2.1-1.95H2.75A.75.75 0 0 1 2 10Z" clip-rule="evenodd" />
            </svg>
            )
          end
        end
      end
    end
  end
end
