require_relative 'nhsuk'

# Extend the design system module to include Ndrsuk
module DesignSystem
  # This is the NDRS branding adapter for the design system
  class Ndrsuk < Nhsuk
  end

  Registry.register(Ndrsuk)
end
