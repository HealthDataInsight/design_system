require_relative 'govuk'

module DesignSystem
  # Module namespace containing all the form builders
  module FormBuilders
    # The NHS version of the form builder
    class Nhsuk < Govuk
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

        content_tag(:div, class: form_group_classes.join(' '), 'data-controller': 'ds--show-password') do
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

        content_tag(:p, hint, id: field_id("#{method}-hint"), class: "#{@brand}-hint")
      end
    end
  end
end
