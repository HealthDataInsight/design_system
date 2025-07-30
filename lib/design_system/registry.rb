module DesignSystem
  # This provides a design system factory
  module Registry
    class << self
      attr_accessor :design_systems

      def register(brand)
        @design_systems ||= []

        @design_systems << brand
      end

      def unregister(*brands)
        brands.each do |brand|
          @design_systems.delete(brand)
        end
      end

      def builder(brand, klass_name, context)
        klass = namespaced_builder_klass(brand, klass_name)

        klass.new(context)
      end

      def form_builder(brand)
        "DesignSystem::#{brand.camelcase}::FormBuilder".constantize
      end

      private

      def namespaced_builder_klass(brand, klass_name)
        raise ArgumentError, "Unknown brand: #{brand}" unless design_systems.include?(brand)

        "DesignSystem::#{brand.camelize}::Builders::#{klass_name.camelize}".constantize
      end
    end
  end
end

require_relative 'all'
