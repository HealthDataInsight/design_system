# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      # This class provides NHSUK Link.
      class Link < ::DesignSystem::Generic::Builders::Link
        private

        def button_type_class_hash
          {
            button: "#{brand}-button",
            secondary_button: "#{brand}-button #{brand}-button--secondary",
            warning_button: "#{brand}-button #{brand}-button--warning",
            reverse_button: "#{brand}-button #{brand}-button--reverse"
          }
        end
      end
    end
  end
end
