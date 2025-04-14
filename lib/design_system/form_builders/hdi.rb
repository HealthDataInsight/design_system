require_relative 'base'
require_relative 'nhsuk'

module DesignSystem
  # Module namespace containing all the form builders
  module FormBuilders
    # The HDI version of the form builder
    class Hdi < Nhsuk
      def ds_password_field(method, options = {})
        @brand = config.brand
        options[:id] = govuk_field_id(method, link_errors: true)
        password_field_options = css_class_options_merge(options, ["#{@brand}-input"])

        hint = options.delete(:hint)
        password_field_options[:'aria-describedby'] = field_id("#{method}-hint") if hint
        password_field_options[:autocomplete] = 'current-password'
        password_field_options['data-ds--show-password-target'] = 'password'
        password_field_options.delete('text')

        content_tag(:div, class: "#{@brand}-form-group", 'data-controller': 'ds--show-password') do
          ds_label(method, {}) +
            optional_hint(method, hint) +
            content_tag(:div, class: "#{@brand}-input__wrapper") do
              password_field(method, password_field_options) + '&nbsp;'.html_safe +
                show_password_button
            end
        end
      end
    end
  end
end
