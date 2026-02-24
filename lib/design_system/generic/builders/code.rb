# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display code blocks.
      class Code < Base
        def render_code(code, language)
          content_tag(:div, class: 'app-example-code', data: { controller: 'ds--clipboard' }) do
            content_tag(:button, 'Copy', class: 'app-copy-button', data: { action: 'click->ds--clipboard#copy', target: 'ds--clipboard.buttonText' }) +
            content_tag(:pre, data: { target: 'ds--clipboard.source' }) do
              content_tag(:code, code, data: { controller: 'ds--code-highlight' }, class: "hljs language-#{language}")
            end
          end
        end
      end
    end
  end
end
