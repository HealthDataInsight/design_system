require_relative 'base'

module DesignSystem
  # Module namespace containing all the form builders
  module FormBuilders
    # The HDI version of the form builder
    class Hdi < Base
      # Same interface as ActionView::Helpers::FormHelper.label
      def ds_label(method, content_or_options = nil, options = {}, &)
        options.merge!({ class: 'block text-sm font-medium leading-6 text-gray-900' })

        label(method, content_or_options, options, &)
      end
    end
  end
end
