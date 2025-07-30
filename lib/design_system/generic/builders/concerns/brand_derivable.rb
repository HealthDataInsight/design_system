module DesignSystem
  module Generic
    module Builders
      module Concerns
        # Mixin module to make brand method available to builder classes
        module BrandDerivable
          def brand
            self.class.name.split('::')[1].underscore
          end
        end
      end
    end
  end
end
