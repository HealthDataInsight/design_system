module DesignSystem
  # This concern manages choosing the relevant layout for our given design system
  module Branded
    extend ActiveSupport::Concern

    included do
      # layout :brand
    end

    def brand
      raise NotImplementedError, 'You need to implement #brand in your ApplicationController'
    end
  end
end
