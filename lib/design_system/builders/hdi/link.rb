# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides HDI Link.
      class Link < ::DesignSystem::Builders::Generic::Link
        private

        def button_style_class_hash
          {
            'button-primary' => "#{brand}-button",
            'button-secondary' => "#{brand}-button #{brand}-button--secondary",
            'button-warning' => "#{brand}-button #{brand}-button--warning"
          }
        end
      end
    end
  end
end
