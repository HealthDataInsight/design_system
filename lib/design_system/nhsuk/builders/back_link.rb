# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      # This class provides NHSUK Back Link.
      class BackLink < ::DesignSystem::Generic::Builders::BackLink
        private

        def prep_back_link_style(path, text)
          content_tag(:div, class: "#{brand}-back-link") do
            content_tag(:a, class: "#{brand}-back-link__link", href: path) do
              arrow_icon + text
            end
          end
        end

        # SVG for the arrow icon
        def arrow_icon
          %(
          <svg class="#{brand}-icon #{brand}-icon__chevron-left" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true" height="24" width="24">
          <path d="M8.5 12c0-.3.1-.5.3-.7l5-5c.4-.4 1-.4 1.4 0s.4 1 0 1.4L10.9 12l4.3 4.3c.4.4.4 1 0 1.4s-1 .4-1.4 0l-5-5c-.2-.2-.3-.4-.3-.7z"></path>
          </svg>
          ).html_safe
        end
      end
    end
  end
end
