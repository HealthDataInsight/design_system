# frozen_string_literal: true

require 'design_system/builders/nhsuk/button'

module DesignSystem
  module Builders
    module Hdi
      # This class provides methods to render HDI button.
      class Button < ::DesignSystem::Builders::Nhsuk::Button
        def render_button(content_or_options = nil, options = nil, &)
          options = prep_button_options(content_or_options, options)
          options[:class] = "#{brand}-button"
          options[:class] << " #{brand}-button--disabled" if options['disabled']

          options = css_class_options_merge(options) do |button_classes|
            button_classes << style_class_hash[options['type']]
          end

          if block_given?
            button_tag(options = nil, &)
          else
            button_tag(content_or_options, options)
          end
        end
      end
    end
  end
end
