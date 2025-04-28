# frozen_string_literal: true

require 'design_system/builders/generic/link'

module DesignSystem
  module Builders
    module Govuk
      # This class provides GOVUK Link.
      class Link < ::DesignSystem::Builders::Generic::Link
        private

        def style_class_hash
          {
            'button-primary' => "#{brand}-button",
            'button-secondary' => "#{brand}-button #{brand}-button--secondary",
            'button-warning' => "#{brand}-button #{brand}-button--warning",
            'button-reverse' => "#{brand}-button #{brand}-button--inverse"
          }
        end
      end
    end
  end
end
