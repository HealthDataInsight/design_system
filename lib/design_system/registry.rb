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

      def fixed_elements(brand, context)
        klass = namespaced_builder_klass(brand, 'FixedElements')

        klass.new(context)
      end

      def table(brand, context, &)
        klass = namespaced_builder_klass(brand, 'Table')

        klass.new(context).render_table(&)
      end

      private

      def namespaced_builder_klass(brand, klass_name)
        raise ArgumentError, "Unknown brand: #{brand}" unless design_systems.include?(brand)

        "DesignSystem::Builders::#{brand.camelize}::#{klass_name}".constantize
      end
    end
  end
end

require_relative 'all'
