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
            options[:class] = if style && style_class_hash[style].present?
                                style_class_hash[style]
                              else
                                "#{brand}-link"
                              end
          else
            style = html_options.delete(:style)
            html_options[:class] = if style && style_class_hash[style].present?
                                     style_class_hash[style]
                                   else
                                     "#{brand}-link"
                                   end
          end

          options = nil if options.empty?
          html_options = nil if html_options.empty?

          link_to(name, options, html_options, &)
        end
      end
    end
  end
end
