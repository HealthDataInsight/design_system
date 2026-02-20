# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display code blocks.
      class Code < Base
        def render_code(code, language)
          content_tag(:pre, class: 'app-example-code') do
            content_tag(:code, code, data: { controller: 'ds--code-highlight' }, class: "hljs language-#{language}")
          end
        end
      end
    end
  end
end
