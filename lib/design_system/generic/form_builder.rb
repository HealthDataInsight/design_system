module DesignSystem
  module Generic
    # The generic version of the form builder
    class FormBuilder < ActionView::Helpers::FormBuilder
      include DesignSystem::Helpers::CssHelper

      delegate :content_tag, :tag, :safe_join, :link_to, :capture, to: :@template

      def self.brand
        self.name.split('::')[1].underscore
      end

      private

      # This method exposes some useful Rails magic as a helper method
      def separate_content_or_options(content_or_options = nil, options = nil)
        content = nil
        options ||= {}

        content_is_options = content_or_options.is_a?(Hash)
        if content_is_options
          options.merge! content_or_options
        else
          content = content_or_options
        end

        [content, options]
      end

      # This method separates the choices for ds_select from options
      def separate_choices_or_options(choices = nil, options = {}, html_options = {})
        if choices.is_a?(Hash) && html_options.empty?
          html_options = options
          options = choices
          choices = []
        end

        choices ||= []

        [choices, options, html_options]
      end
    end
  end
end
