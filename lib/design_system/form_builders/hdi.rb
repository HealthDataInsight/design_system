require_relative 'nhsuk'

module DesignSystem
  # Module namespace containing all the form builders
  module FormBuilders
    # The HDI version of the form builder
    class Hdi < Nhsuk
      # In this instance the string is safe, because it contains known text.
      # rubocop:disable Rails/OutputSafety
      SHOW_PASSWORD_SVG = <<~SVG.html_safe
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="password-field__icon">
          <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
          <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
        </svg>
      SVG
      # rubocop:enable Rails/OutputSafety

      def ds_password_field(method, options = {})
        @brand = config.brand
        options[:id] = govuk_field_id(method, link_errors: true)
        password_field_options = css_class_options_merge(options,
                                                         ["#{@brand}-input #{@brand}-password-field__input",
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
            content_tag(:div, class: "#{@brand}-password-field") do
              password_field(method, password_field_options) +
                show_password_button
            end
        end
      end

      def show_password_button
        button_options = {
          type: 'button',
          class: "#{@brand}-password-field__button",
          aria: { label: 'Show password' },
          data: {
            'module' => "#{@brand}-button",
            'action' => 'click->ds--show-password#toggle',
            'ds--show-password-target' => 'button'
          }
        }
        content_tag(:button, button_options) do
          SHOW_PASSWORD_SVG
        end
      end
    end
  end
end
