# frozen_string_literal: true

require 'design_system/components/tab'
require_relative 'base'

module DesignSystem
  module Builders
    module Generic
      # This class provides generic methods to display button on html.
      class Button < Base
        def render_button(text, _style, options)
          safe_buffer = ActiveSupport::SafeBuffer.new
          safe_buffer.concat(content_tag(:button, text, type: 'submit', **options))
          safe_buffer
        end
      end
    end
  end
end
