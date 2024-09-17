require_relative 'base'

module DesignSystem
  # Module namespace containing all the form builders
  module FormBuilders
    # The HDI version of the form builder
    class Hdi < Base
      # Same interface as ActionView::Helpers::FormHelper.label
      def ds_label(method, content_or_options = nil, options = {}, &)
        content, options = separate_content_or_options(content_or_options, options)
        options = css_class_options_merge(options, %w(block text-sm font-medium leading-6 text-gray-900))

        label(method, content, options, &)
      end
    end
  end
end
