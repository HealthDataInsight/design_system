require_relative 'base'

module DesignSystem
  # This is a stub handler for design systems that aren't in the registry.
  class Unknown < Base
    def initialize(context)
      super
      raise 'Error: Unknown client'
    end
  end
end
