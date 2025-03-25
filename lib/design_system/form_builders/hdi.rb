require_relative 'base'

module DesignSystem
  # Module namespace containing all the form builders
  module FormBuilders
    # The HDI version of the form builder
    class Hdi < Base
      # This builder provider the following helper methods:
      # ds_file_field
      # ds_label
      # ds_password_field
      # ds_text_area
      # ds_text_field

      # TODO: Same interface as ActionView::Helpers::FormHelper.file_field, but with label automatically added?
      # def ds_file_field(method, options = {})
      #   content, options = separate_content_or_options(content_or_options, options)
      # end

      # Same interface as ActionView::Helpers::FormHelper.label
      def ds_label(method, content_or_options = nil, options = {}, &)
        content, options = separate_content_or_options(content_or_options, options)
        label(method, content, options.merge(class: 'hdi-label'), &)
      end

      # Same interface as ActionView::Helpers::FormHelper.password_field, but with label automatically added.
      def ds_password_field(method, options = {})
        options = options.merge(class: 'hdi-input')

        hint = options.delete(:hint)
        options[:'aria-describedby'] = field_id("#{method}-hint") if hint
        options[:autocapitalize] = 'none'
        options[:autocomplete] = 'current-password'
        options[:spellcheck] = 'false'

        content_tag(:div) do
          ds_label(method) +
          optional_hint(method, hint) +
          content_tag(:div, class: 'mt-2') do
            password_field(method, options)
          end
        end
      end

      # TODO: Same interface as ActionView::Helpers::FormHelper.text_area, but with label automatically added?
      def ds_text_area(method, options = {})
        options = options.merge(class: 'hdi-textarea')

        hint = options.delete(:hint)
        options['aria-describedby'] = field_id("#{method}-hint") if hint

        content_tag(:div, class: 'hdi-form-group') do
          ds_label(method) +
          optional_hint(method, hint) +
          text_area(method, options)
        end
      end

      def ds_collection_select(method, collection, value_method, text_method, options = {})
        html_options = options.extract!(:class, :id, :style, :data, :aria)
        html_options = html_options.merge(class: 'hdi-select')

        hint = options.delete(:hint)
        html_options[:'aria-describedby'] = field_id("#{method}-hint") if hint

        content_tag(:div, class: 'hdi-form-group') do
          ds_label(method) +
          optional_hint(method, hint) +
          collection_select(method, collection, value_method, text_method, options, html_options)
        end
      end

      def ds_collection_check_boxes(method, collection, value_method, text_method, options = {})
        options = options.merge(class: 'hdi-checkboxes', include_hidden: false)

        hint = options.delete(:hint)
        legend = options.delete(:legend)
        
        content_tag(:div, class: 'hdi-form-group') do
          content_tag(:fieldset, class: 'hdi-fieldset', 'aria-describedby': hint ? field_id("#{method}-hint") : nil) do
            optional_fieldset_legend(method, legend) +
            optional_hint(method, hint) +
            content_tag(:div, class: 'hdi-checkboxes') do
              collection_check_boxes(method, collection, value_method, text_method, options) do |b|
                content_tag(:div, class: 'hdi-checkboxes__item') do
                  b.check_box(class: 'hdi-checkboxes__input') +
                  b.label(class: 'hdi-checkboxes__label')
                end
              end
            end
          end
        end
      end

      # Same interface as ActionView::Helpers::FormHelper.text_field, but with label automatically added.
      def ds_text_field(method, options = {})
        options[:class] = Array(options[:class]) + ['hdi-input']

        hint = options.delete(:hint)
        options['aria-describedby'] = field_id("#{method}-hint") if hint

        # width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
        # TODO: support width by ratio of screen width
        width = options.delete(:width)
        if width
          allowed = [2, 3, 4, 5, 10, 20]
          raise ArgumentError, 'Invalid width, must be one of 2, 3, 4, 5, 10, or 20.' unless allowed.include?(width.to_i)

          options[:class] += ["hdi-input--width-#{width}"]
        end

        content_tag(:div, class: 'hdi-form-group') do
          ds_label(method) +
          optional_hint(method, hint) +
          text_field(method, options)
        end
      end

      private

      def optional_hint(method, hint)
        return nil if hint.nil?

        content_tag(:div, hint, id: field_id("#{method}-hint"), class: 'hdi-hint')
      end

      def optional_fieldset_legend(method, legend)
        return nil if legend.nil?

        content_tag(:legend, class: 'hdi-fieldset__legend') do
          content_tag(:h1, legend, class: 'hdi-fieldset__heading')
        end
      end
    end
  end
end
