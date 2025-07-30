# frozen_string_literal: true

module DesignSystem
  module Hdi
    module Builders
      # This class provides methods to render HDI button.
      class Button < ::DesignSystem::Generic::Builders::Button
        def render_button(content_or_options = nil, options = nil, &)
          options = prep_button_options(content_or_options, options)
          options[:class] = 'font-bold py-2 px-4 rounded-sm'

          options = css_class_options_merge(options) do |button_classes|
            button_classes << style_class_hash[options['style']]
          end

          options = add_disabled_class(options) if options[:disabled]

          if block_given?
            button_tag(options = nil, &)
          else
            button_tag(content_or_options, options)
          end
        end

        def render_start_button(_text, _href, _options)
          nil
        end

        private

        def add_disabled_class(options)
          css_class_options_merge(options) do |button_classes|
            button_classes << 'disabled:bg-gray-300 text-indigo-500 cursor-not-allowed'
          end
        end

        def style_class_hash
          {
            'primary' => 'bg-indigo-600 hover:bg-indigo-500 text-white',
            'secondary' => 'bg-white-500 hover:bg-gray-50 text-gray',
            'warning' => 'bg-red-500 hover:bg-red-600 text-white',
            'reverse' => 'bg-white hover:bg-indigo-400 text-indigo-500'
          }
        end
      end
    end
  end
end
