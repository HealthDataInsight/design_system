require_relative 'nhsuk'

module DesignSystem
  # This is the NDRS branding adapter for the design system
  class Ndrsuk < Nhsuk
  end

  Registry.register(Ndrsuk, 'ndrsuk')
end
