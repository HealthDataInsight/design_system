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
            'primary' => "#{brand}-button",
            'secondary' => "#{brand}-button #{brand}-button--secondary",
            'warning' => "#{brand}-button #{brand}-button--warning",
            'reverse' => "#{brand}-button #{brand}-button--inverse"
          }
        end
      end
    end
  end
end
