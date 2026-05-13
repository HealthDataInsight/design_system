module DesignSystem
  module Generic
    # Generic page heading. Brand subclasses inherit unchanged.
    class HeadingComponent < DesignSystem::BaseComponent
      SIZE_MAPPING = {
        1 => 'xl',
        2 => 'l',
        3 => 'm',
        4 => 's',
        5 => 'xs',
        6 => 'xs'
      }.freeze

      def initialize(text, level: 2, **options)
        super()
        @text = text
        @level = level.to_i
        @options = options
        validate_level!
      end

      attr_reader :text, :level, :options

      def call
        content_tag("h#{level}", text, class: heading_class, **options)
      end

      private

      def heading_class
        "#{brand}-heading-#{SIZE_MAPPING[level]}"
      end

      def validate_level!
        return if level.between?(1, 6)

        raise ArgumentError, "Invalid heading level #{level}. Must be an integer between 1 and 6."
      end
    end
  end
end
