# frozen_string_literal: true

module DesignSystem
  module Builders
    module Nhsuk
      # This class provides NHSUK Link.
      class Link < ::DesignSystem::Builders::Generic::Link
        private

        def style_class_hash
          {
            'button-primary' => "#{brand}-button",
            'button-secondary' => "#{brand}-button #{brand}-button--secondary",
            'button-warning' => "#{brand}-button #{brand}-button--warning",
            'button-reverse' => "#{brand}-button #{brand}-button--reverse"
          }
        end
      end
    end
  end
end
