# frozen_string_literal: true

require 'design_system/components/tab'
require_relative 'base'

module DesignSystem
  module Generic
    module Builders
      # This class provides generic methods to display tab on html.
      class Tab < Base
        def render_tabs
          raise 'Subclass needs to implement brand specific render_tabs'
        end
      end
    end
  end
end
