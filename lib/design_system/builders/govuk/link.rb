# frozen_string_literal: true

require 'design_system/builders/generic/link'

module DesignSystem
  module Builders
    module Govuk
      # This class provides GOVUK Link.
      class Link < ::DesignSystem::Builders::Generic::Link
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
