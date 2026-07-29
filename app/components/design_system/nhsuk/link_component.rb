module DesignSystem
  module Nhsuk
    # NHS link: maps button :type values to nhsuk-button style classes.
    class LinkComponent < DesignSystem::Generic::LinkComponent
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
