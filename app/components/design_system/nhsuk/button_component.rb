module DesignSystem
  module Nhsuk
    class ButtonComponent < DesignSystem::Generic::ButtonComponent

      def style_class_hash
        {
          'secondary' => "#{brand}-button--secondary",
          'warning' => "#{brand}-button--warning",
          'reverse' => "#{brand}-button--reverse"
        }
      end
    end
  end
end
