module DesignSystem
  module Generic
    # Renders a block of code with a copy button, used by ds_code. Brand
    # subclasses inherit the markup unchanged.
    class CodeComponent < DesignSystem::BaseComponent
      def initialize(code:, language:)
        super()
        @code = code
        @language = language
      end

      attr_reader :code, :language

      def call
        content_tag(:div, class: 'app-example__code', data: { controller: 'ds--clipboard' }) do
          copy_button + scroll_area
        end
      end

      private

      def copy_button
        content_tag(:button, 'Copy',
                    class: 'app-example__copy-button',
                    data: { action: 'click->ds--clipboard#copy', 'ds--clipboard-target': 'buttonText' })
      end

      def scroll_area
        content_tag(:div, class: 'app-example__scroll', tabindex: 0) do
          content_tag(:pre, data: { 'ds--clipboard-target': 'source' }) do
            content_tag(:code, code,
                        data: { controller: 'ds--code-highlight' },
                        class: "hljs language-#{language}")
          end
        end
      end
    end
  end
end
