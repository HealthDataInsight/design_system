# Reproduced from NdrUi css_helper.rb with thanks
# https://github.com/NHSDigital/ndr_ui/blob/3597e609c808846f531a42a50c69abaf41a96155/app/helpers/ndr_ui/css_helper.rb

module DesignSystem
  module Helpers
    # Provides CSS helper methods
    module CssHelper
      # This method merges the specified css_classes into the options hash
      def css_class_options_merge(options, css_classes = [], &)
        options = options.symbolize_keys
        css_classes += options[:class].split if options.include?(:class)
        yield(css_classes) if block_given?
        options[:class] = css_classes.join(' ') unless css_classes.empty?
        raise "Multiple css class definitions: #{css_classes.inspect}" unless css_classes == css_classes.uniq

        options
      end
    end
  end
end
