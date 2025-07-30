# frozen_string_literal: true

require 'design_system/generic/builders/link'

module DesignSystem
  module Govuk
    module Builders
      # This class provides GOVUK Link.
      class Link < ::DesignSystem::Generic::Builders::Link
        private

        def button_type_class_hash
          {
            button: "#{brand}-button",
            secondary_button: "#{brand}-button #{brand}-button--secondary",
            warning_button: "#{brand}-button #{brand}-button--warning",
            reverse_button: "#{brand}-button #{brand}-button--inverse"
          }
        end
      end
    end
  end
end
