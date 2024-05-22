module DesignSystem
  # This concern manages choosing the relevant layout for our given design system
  module Branded
    extend ActiveSupport::Concern

    included do
      attr_reader :navigation_items

      helper DesignSystemHelper

      # TODO: Work out how to use a hook to include this
      helper HdiHelper
    end

    def brand
      raise NotImplementedError, 'You need to implement #brand in your ApplicationController'
    end

    def add_navigation_item(label, path)
      @navigation_items ||= []
      @navigation_items << { label: label, path: path }
    end
  end
end
