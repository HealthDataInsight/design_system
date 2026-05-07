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

      # Resolves a per-brand component class. The component is responsible for
      # rendering — call `render(component(brand, :panel).new(...))` from a
      # helper. Coexists with `builder` during the gradual migration from
      # PORO builders to ViewComponents.
      def component(brand, name)
        raise ArgumentError, "Unknown brand: #{brand}" unless design_systems.include?(brand)

        klass_name = "DesignSystem::#{brand.camelize}::#{name.to_s.camelize}Component"
        klass_name.safe_constantize ||
          raise(ArgumentError, "Unknown component: #{name} for brand #{brand}")
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
