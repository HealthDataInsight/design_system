# frozen_string_literal: true

require_relative 'base'

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display links on html, including button links.
      class Link < Base
        def render_link_to(name = nil, options = nil, html_options = nil, &)
          options ||= {}
          html_options ||= {}

          if block_given?
            type = options.delete(:type)
            options[:class] = prep_link_classes(type)
          else
            type = html_options.delete(:type)
            html_options[:class] = prep_link_classes(type)
          end

          link_to(name, options, html_options, &)
        end

        private

        def prep_link_classes(type)
          if type && button_type_class_hash[type].present?
            button_type_class_hash[type]
          else
            "#{brand}-link"
          end
        end
      end
    end
  end
end
