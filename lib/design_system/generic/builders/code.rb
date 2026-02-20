# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display code blocks.
      class Code < Base
        def render_code(code)
          content_tag(:pre, class: 'app-example-code') do
            content_tag(:code, code)
          end
        end
      end
    end
  end
end
