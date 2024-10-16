# frozen_string_literal: true

require 'design_system/components/tab'
require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display button on html.
      class Button < Base
        include Rails.application.routes.url_helpers

        def render_button(text, _style, options)
          safe_buffer = ActiveSupport::SafeBuffer.new

          href_path = options[:href].is_a?(Hash) ? url_for(options[:href]) : options[:href]
          merged_options = options.except(:href)
          content_tag_button = if href_path
                                 content_tag(:a, text,
                                             { href: href_path, role: 'button', **merged_options })
                               else
                                 content_tag(:button, text, type: 'submit', **merged_options)
                               end
          safe_buffer.concat(content_tag_button)
          safe_buffer
        end
      end
    end
  end
end
