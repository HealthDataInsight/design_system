# frozen_string_literal: true

require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display links on html, including button links.
      class Link < Base
        def render_link_to(name = nil, options = nil, html_options = nil, &)
          style = html_options.delete(:style)
          if style_class_hash[style]
            html_options = css_class_options_merge(html_options) do |button_classes|
              button_classes << style_class_hash[style]
            end
          else
            html_options[:class] = "#{brand}-link"
          end

          link_to(name, options, html_options, &)
        end
      end
    end
  end
end
