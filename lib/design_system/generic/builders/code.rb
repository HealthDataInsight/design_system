# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # Renders a code block with copy button.
      class Code < Base
        def render_code(code, language)
          content_tag(:div, class: 'app-example__code', data: { controller: 'ds--clipboard' }) do
            content_tag(:button, 'Copy', class: 'app-example__copy-button',
                                         data: { action: 'click->ds--clipboard#copy', target: 'ds--clipboard.buttonText' }) +
              content_tag(:div, class: 'app-example__scroll') do
                content_tag(:pre, data: { target: 'ds--clipboard.source' }) do
                  content_tag(:code, code, data: { controller: 'ds--code-highlight' },
                                           class: "hljs language-#{language}")
                end
              end
          end
        end
      end
    end
  end
end
