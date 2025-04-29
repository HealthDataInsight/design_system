# frozen_string_literal: true

require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display links on html, including button links.
      class Link < Base
        def render_link_to(name = nil, options = nil, html_options = nil, &)
          options ||= {}
          html_options ||= {}

          if block_given?
            style = options.delete(:style)
            options[:class] = prep_link_classes(style)
          else
            style = html_options.delete(:style)
            html_options[:class] = prep_link_classes(style)
          end

          link_to(name, options, html_options, &)
        end

        private

        def prep_link_classes(style)
          if style && button_style_class_hash[style].present?
            button_style_class_hash[style]
          else
            "#{brand}-link"
          end
        end
      end
    end
  end
end
