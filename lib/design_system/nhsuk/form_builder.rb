require 'design_system/govuk/form_builder'

module DesignSystem
  # Module namespace containing all the form builders
  module Nhsuk
    # The NHS version of the form builder
    class FormBuilder < DesignSystem::Govuk::FormBuilder
      # Same interface as ActionView::Helpers::FormHelper.hidden_field, but with label automatically added and takes a show_text option
      def ds_hidden_field(method, options = {})
        @brand = config.brand

        options[:class] = Array(options[:class])
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

      def ds_password_field(method, options = {})
        @brand = config.brand
        options[:id] = govuk_field_id(method, link_errors: true)
        password_field_options = css_class_options_merge(options,
                                                         ["#{@brand}-input",
                                                          has_errors?(method) ? "#{@brand}-input--error" : nil].compact)

        hint = options.delete(:hint)
        password_field_options[:'aria-describedby'] = field_id("#{method}-hint") if hint
        password_field_options[:autocomplete] = 'current-password'
        password_field_options['data-ds--show-password-target'] = 'password'
        password_field_options.delete('text')

        form_group_classes = ["#{@brand}-form-group"]
        form_group_classes << "#{@brand}-form-group--error" if has_errors?(method)

        content_tag(:div,
                    class: form_group_classes.join(' '),
                    data: {
                      controller: 'ds--show-password',
                      'ds--show-password-show-text-value': 'Show password',
                      'ds--show-password-hide-text-value': 'Hide password'
                    }) do
          ds_label(method, {}) +
            optional_hint(method, hint) +
            password_field(method, password_field_options) + '&nbsp;'.html_safe +
            show_password_button
        end
      end

      def show_password_button
        button_options = {
          type: 'button',
          class: "#{@brand}-button #{@brand}-button--secondary",
          style: 'padding: 8px 10px 7px; margin-bottom: 0px !important',
          aria: { label: 'Show password' },
          data: {
            'module' => "#{@brand}-button",
            'action' => 'click->ds--show-password#toggle',
            'ds--show-password-target' => 'button'
          }
        }
        content_tag(:button, 'Show password', button_options)
      end

      private

      def optional_hint(method, hint)
        return nil if hint.nil?

        content_tag(:div, hint, id: field_id("#{method}-hint"), class: "#{@brand}-hint")
      end
    end
  end
end
