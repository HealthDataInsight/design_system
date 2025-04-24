# require_relative 'base'

module DesignSystem
  module FormBuilders
    # The base version of the form builder
    class Base < ActionView::Helpers::FormBuilder
      delegate :content_tag, :tag, :safe_join, :link_to, :capture, to: :@template

      def self.brand
        name.demodulize.underscore
      end

      # Same interface as ActionView::Helpers::FormHelper.hidden_field, but with label automatically added and takes a show_text option
      def ds_hidden_field(method, options = {})
        @brand = config.brand

        options[:class] ||= []
        options[:class] << "#{@brand}-u-visually-hidden"

        label_hash = options.delete(:label) || {}
        label = ds_label(method, label_hash)
        show_text = options.delete(:show_text)

        content_tag(:div, class: "#{@brand}-form-group") do
          components = []
          components << label if label
          components << hidden_field(method, **options)
          components << content_tag(:span, show_text, class: "#{@brand}-body-m") if show_text

          safe_join(components)
        end
      end

      private

      # Helper copied from https://github.com/NHSDigital/ndr_ui/blob/main/app/helpers/ndr_ui/css_helper.rb with thanks.
      # This method merges the specified css_classes into the options hash
      def css_class_options_merge(options, css_classes = [])
        options = options.symbolize_keys
        css_classes += options[:class].split if options.include?(:class)
        yield(css_classes) if block_given?
        options[:class] = css_classes.join(' ') unless css_classes.empty?
        raise "Multiple css class definitions: #{css_classes.inspect}" unless css_classes == css_classes.uniq

        options
      end

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
