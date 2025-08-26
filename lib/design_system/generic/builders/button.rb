# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display button on html.
      class Button < Base
        def render_button(content_or_options = nil, options = nil, &)
          options = prep_button_options(content_or_options, options)

          if block_given?
            button_tag(options = nil, &)
          else
            button_tag(content_or_options, options)
          end
        end

        private

        def prep_button_options(content_or_options, options)
          if content_or_options.is_a? Hash
            options = content_or_options
          else
            options ||= {}
          end

          { 'name' => 'button', 'type' => 'submit',
            'data-module' => "#{brand}-button" }.merge!(options.stringify_keys)
        end
      end
    end
  end
end
