module DesignSystem
  # This concern manages choosing the relevant layout for our given design system
  module Branded
    extend ActiveSupport::Concern

    included do
      attr_reader :navigation_items

      helper DesignSystemHelper
    end

    def brand
      raise NotImplementedError, 'You need to implement #brand in your ApplicationController'
    end

    def add_navigation_item(label, path, options = {})
      @navigation_items ||= []
      @navigation_items << { label:, path:, options: }
    end
  end
end
