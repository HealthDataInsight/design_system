# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This class is used to provide will_paginate renderer.
      class PaginationRenderer < WillPaginate::ActionView::LinkRenderer
        include DesignSystem::Builders::Concerns::BrandDerivable

        def initialize(context)
          @context = context
        end

        def container_attributes
          { class: "#{brand}-pagination", role: 'navigation', 'aria-label': 'Pagination' }
        end

        def html_container(html)
          # Wrap pagination items in the correct container
          tag(:nav, tag(:ul, html, class: "#{brand}-list #{brand}-pagination__list"), container_attributes)
        end

        def previous_or_next_page(page, text, classname)
          if classname.include?('previous_page')
            if page
              tag(:li, link_with_title(text, page, 'Previous', previous_icon),
                  class: "#{brand}-pagination-item--previous")
            else
              tag(:li, disabled_link_with_title(text, 'Previous'), class: "#{brand}-pagination-item--previous")
            end
          elsif classname.include?('next_page')
            if page
              tag(:li, link_with_title(text, page, 'Next', next_icon), class: "#{brand}-pagination-item--next")
            else
              tag(:li, disabled_link_with_title(text, 'Next'), class: "#{brand}-pagination-item--next")
            end
          end
        end

        private

        def link_with_title(text, target, title, icon)
          tag(:a, tag(:span, title, class: "#{brand}-pagination__title") +
          tag(:span, ':', class: "#{brand}-u-visually-hidden") +
          tag(:span, text, class: "#{brand}-u-visually-hidden") +
          icon, href: url(target), class: "#{brand}-pagination__link")
        end

        def disabled_link_with_title(text, title)
          tag(:span,
              tag(:span, title, class: "#{brand}-pagination__title") +
              tag(:span, text, class: "#{brand}-u-visually-hidden"),
              class: "#{brand}-pagination__link disabled")
        end

        # SVG for the "Previous" icon
        def previous_icon
          %(
          <svg class="#{brand}-icon nhsuk-icon__arrow-left" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true" width="34" height="34">
          <path d="M4.1 12.3l2.7 3c.2.2.5.2.7 0 .1-.1.1-.2.1-.3v-2h11c.6 0 1-.4 1-1s-.4-1-1-1h-11V9c0-.2-.1-.4-.3-.5h-.2c-.1 0-.3.1-.4.2l-2.7 3c0 .2 0 .4.1.6z"></path>
          </svg>
          )
        end

        # SVG for the "Next" icon
        def next_icon
          %(
          <svg class="#{brand}-icon nhsuk-icon__arrow-right" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true" width="34" height="34">
          <path d="M19.9 11.7l-2.7-3c-.2-.2-.5-.2-.7 0-.1.1-.1.2-.1.3v2H5c-.6 0-1 .4-1 1s.4 1 1 1h11v2c0 .2.1.4.3.5h.2c.1 0 .3-.1.4-.2l2.7-3c0-.2 0-.4-.1-.6z"></path>
          </svg>
          )
        end
      end
    end
  end
end
