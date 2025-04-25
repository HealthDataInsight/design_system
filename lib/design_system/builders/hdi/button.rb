# frozen_string_literal: true

module DesignSystem
  module Builders
    module Hdi
      # This class provides methods to render HDI button.
      class Button < ::DesignSystem::Builders::Govuk::Button
        private

        def style_class_hash
          {
            'secondary' => "#{brand}-button--secondary",
            'warning' => "#{brand}-button--warning"
          }
        end
      end
    end
  end
end
