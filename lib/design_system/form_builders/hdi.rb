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
      # end

      # Same interface as ActionView::Helpers::FormHelper.label
      def ds_label(method, content_or_options = nil, options = {}, &)
        content, options = separate_content_or_options(content_or_options, options)
        options = css_class_options_merge(options, %w[block text-sm font-medium leading-6 text-gray-900])

        label(method, content, options, &)
      end

      # Same interface as ActionView::Helpers::FormHelper.password_field, but with label automatically added.
      def ds_password_field(method, options = {})
        options = css_class_options_merge(options, %w[
                                            block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm
                                            ring-1 ring-inset ring-gray-300 placeholder:text-gray-400
                                            focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6
                                          ])

        options[:autocapitalize] = 'none'
        options[:autocomplete] = 'current-password'
        options[:spellcheck] = 'false'

        content_tag(:div) do
          ds_label(method) +
            content_tag(:div, class: 'mt-2') do
              password_field(method, options)
            end
        end
      end

      # TODO: Same interface as ActionView::Helpers::FormHelper.text_area, but with label automatically added?
      # def ds_text_area(method, options = {})
      # end

      # Same interface as ActionView::Helpers::FormHelper.text_field, but with label automatically added.
      def ds_text_field(method, options = {})
        options = css_class_options_merge(options, %w[
                                            block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm
                                            ring-1 ring-inset ring-gray-300 placeholder:text-gray-400
                                            focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6
                                          ])

        content_tag(:div) do
          ds_label(method) +
            content_tag(:div, class: 'mt-2') do
              text_field(method, options)
            end
        end
      end
    end
  end
end
