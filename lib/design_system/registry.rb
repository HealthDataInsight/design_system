module DesignSystem
  # This provides a design system factory 
  module Registry
    class << self
      attr_accessor :design_systems

      def register(klass, *brands)
        @design_systems ||= {}

        brands.each do |brand|
          @design_systems[brand] = klass
        end
      end

      def unregister(*brands)
        brands.each do |brand|
          @design_systems.delete(brand)
        end
      end

      def design_system(brand, context)
        klass = Registry.design_systems.fetch(brand, Unknown)

        klass.new(brand, context)
      end
    end
  end
end

require_relative 'all'
