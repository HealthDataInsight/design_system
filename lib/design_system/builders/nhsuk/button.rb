# frozen_string_literal: true

module DesignSystem
  module Builders
    module Nhsuk
      # This class provides Nhsuk Button.
      class Button < ::DesignSystem::Builders::Govuk::Button
        private

        def style_class_hash
          {
            secondary: "#{brand}-button--secondary",
            warning: "#{brand}-button--warning",
            reverse: "#{brand}-button--reverse"
          }
        end
      end
    end
  end
end
