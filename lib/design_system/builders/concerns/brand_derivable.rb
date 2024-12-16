module DesignSystem
  module Builders
    module Concerns
      # Mixin module to make brand method available to builder classes
      module BrandDerivable
        def brand
          self.class.name.split('::')[2].underscore
        end
      end
    end
  end
end
