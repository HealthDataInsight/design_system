module DesignSystem
  # Base class for all design-system view components. Provides the brand
  # derivation and shared CSS helpers.
  class BaseComponent < ::ViewComponent::Base
    include DesignSystem::BrandDerivable
    include DesignSystem::Helpers::CssHelper
  end
end
