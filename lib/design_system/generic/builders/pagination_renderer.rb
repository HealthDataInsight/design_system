# frozen_string_literal: true

require 'will_paginate/view_helpers/action_view'

module DesignSystem
  module Generic
    module Builders
      # This class is used to provide will_paginate renderer.
      class PaginationRenderer < WillPaginate::ActionView::LinkRenderer
        include DesignSystem::Generic::Builders::Concerns::BrandDerivable

        def initialize(context)
          @context = context
          super()
        end

        def container_attributes
          { class: "#{brand}-pagination", role: 'navigation', 'aria-label': 'Pagination' }
        end

        def html_container(html)
          # Wrap pagination items in the correct container
          tag(:nav, tag(:ul, html, class: "#{brand}-list #{brand}-pagination__list"), container_attributes)
        end

        def previous_or_next_page(page, text, classname, aria_label = nil)
          if classname.include?('previous_page')
            build_page_item(page, text, 'Previous', previous_icon, "#{brand}-pagination-item--previous", aria_label)
          elsif classname.include?('next_page')
            build_page_item(page, text, 'Next', next_icon, "#{brand}-pagination-item--next", aria_label)
          end
        end

        private

        def build_page_item(page, text, title, icon, css_class, aria_label)
          if page
            tag(:li, link_with_title(text, page, title, icon, aria_label), class: css_class)
          else
            tag(:li, disabled_link_with_title(text, title, aria_label), class: css_class)
          end
        end

        def link_with_title(text, target, title, icon, aria_label = nil)
          tag(:a, tag(:span, title, class: "#{brand}-pagination__title") +
          tag(:span, ':', class: "#{brand}-u-visually-hidden") +
          tag(:span, text, class: "#{brand}-u-visually-hidden") +
          icon, href: url(target), class: "#{brand}-pagination__link",
                'aria-label': aria_label)
        end

        def disabled_link_with_title(text, title, aria_label = nil)
          tag(:span,
              tag(:span, title, class: "#{brand}-pagination__title") +
              tag(:span, text, class: "#{brand}-u-visually-hidden"),
              class: "#{brand}-pagination__link disabled",
              'aria-label': aria_label)
        end

        # SVG for the "Previous" icon
        def previous_icon
          %(
          <svg class="#{brand}-icon nhsuk-icon--arrow-left" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" focusable="false" aria-hidden="true">
            <path d="M10.7 6.3c.4.4.4 1 0 1.4L7.4 11H19a1 1 0 0 1 0 2H7.4l3.3 3.3c.4.4.4 1 0 1.4a1 1 0 0 1-1.4 0l-5-5A1 1 0 0 1 4 12c0-.3.1-.5.3-.7l5-5a1 1 0 0 1 1.4 0Z"/>
          </svg>
          )
        end

        # SVG for the "Next" icon
        def next_icon
          %(
          <svg class="#{brand}-icon nhsuk-icon--arrow-right" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" focusable="false" aria-hidden="true">
            <path d="m14.7 6.3 5 5c.2.2.3.4.3.7 0 .3-.1.5-.3.7l-5 5a1 1 0 0 1-1.4-1.4l3.3-3.3H5a1 1 0 0 1 0-2h11.6l-3.3-3.3a1 1 0 1 1 1.4-1.4Z"/>
          </svg>
          )
        end
      end
    end
  end
end
