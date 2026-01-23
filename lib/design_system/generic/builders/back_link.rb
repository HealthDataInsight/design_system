# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display back link.
      class BackLink < Base
        def render_back_link(path, text = 'Back')
          prep_back_link_style(path, text)
        end

        private

        def prep_back_link_style(path, text)
          content_tag(:a, href: path, class: "#{brand}-back-link") do
            text
          end
        end
      end
    end
  end
end
