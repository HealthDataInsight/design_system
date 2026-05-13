module DesignSystem
  # Base class for all design-system view components. Provides the brand
  # derivation and shared CSS helpers.
  #
  # On the inheritance pattern (Brand::FooComponent < Generic::FooComponent):
  # ViewComponent's docs recommend avoiding inheritance, but that guidance is
  # aimed at typical application components, not multi-brand design systems.
  # Here, Govuk::PanelComponent really is a specialization of the same
  # conceptual panel as Nhsuk's, and ViewComponent's ancestor-walking template
  # resolution lets Generic own the markup while brand classes override only
  # what they need (e.g. an extra CSS modifier). The alternatives we weighed —
  # one component with a `brand:` param, or sharing via a Concern — each trade
  # more than they save: the param approach buries brand-specific behaviour in
  # conditionals, and Concerns fight ViewComponent's sidecar-template model.
  # We accept the occasional empty subclass in exchange for a uniform,
  # predictable structure across the library.
  class BaseComponent < ::ViewComponent::Base
    include DesignSystem::BrandDerivable
    include DesignSystem::Helpers::CssHelper
  end
end
