module DesignSystem
  # This provides a design system factory
  module Registry
    class << self
      attr_accessor :design_systems

      def register(klass)
        @design_systems ||= {}

        brand = klass.name.split('::').last.underscore
        @design_systems[brand] = klass
      end

      def unregister(*brands)
        brands.each do |brand|
          @design_systems.delete(brand)
        end
      end

      def design_system(brand, context)
        klass = Registry.design_systems.fetch(brand, Unknown)

        klass.new(context)
      end

      def table(brand, context, &)
        klass = "DesignSystem::Builders::#{brand.camelize}::Table".constantize

        klass.new(context).render_table(&)
      end
    end
  end
end

require_relative 'all'
