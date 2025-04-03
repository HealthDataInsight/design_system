# require_relative 'base'

module DesignSystem
  module FormBuilders
    # The base version of the form builder
    class Base < ActionView::Helpers::FormBuilder
      delegate :content_tag, :tag, :safe_join, :link_to, :capture, to: :@template

      def self.brand
        name.demodulize.underscore
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

      # This method separates the options and values and distinguishes between checked and unchecked values
      # It's a helper for checkboxes
      def separate_options_and_value(options, checked_value, unchecked_value)
        if options.is_a?(Hash)
          value = checked_value
        else
          value = options
          unchecked_value = (checked_value == '1' ? false : checked_value)
          options = {}
        end

        value = true if value == '1'
        unchecked_value = false if unchecked_value == '0'
        options ||= {}

        [options, value, unchecked_value]
      end

      # This method separates the choices and options from the html_options
      def separate_choices_or_options(choices = nil, options = nil, html_options = nil)
        if choices.is_a?(Hash) && html_options.nil?
          options, html_options = separate_rails_or_html_options(choices, options)
          choices = nil
        end

        options ||= {}
        html_options ||= {}

        [choices, options, html_options]
      end

      # This method separates the rails select options and html_options
      def separate_rails_or_html_options(options = nil, html_options = nil)
        if html_options.nil? && !rails_options?(options)
          html_options = options
          options = nil
        end

        [options, html_options]
      end

      # Helper to check if a hash contains Rails form options
      # If it doesn't, it means that the options are html options
      # TODO: Support mixed options?
      def rails_options?(hash)
        rails_options = %i[
          form_group
          hint
          include_blank
          label
          legend
          prompt
        ]

        hash.is_a?(Hash) && hash.keys.any? { |key| rails_options.include?(key) }
      end
    end
  end
end
