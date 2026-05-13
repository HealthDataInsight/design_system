module DesignSystem
  # Mixin that derives the design-system brand name from the including class's
  # second-level namespace (e.g. `DesignSystem::Govuk::PanelComponent` → `'govuk'`).
  module BrandDerivable
    def brand
      self.class.name.split('::')[1].underscore
    end
  end
end
