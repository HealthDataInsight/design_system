# frozen_string_literal: true

require 'design_system/generic/builders/concerns/brand_derivable'
require 'design_system/helpers/css_helper'

module DesignSystem
  module Generic
    module Builders
      # This is the base class for design system builders.
      class Base
        include DesignSystem::Generic::Builders::Concerns::BrandDerivable
        include DesignSystem::Helpers::CssHelper

        delegate :button_tag, :capture, :content_for, :content_tag, :link_to, :link_to_unless_current, to: :@context

        def initialize(context)
          @context = context
        end
      end
    end
  end
end
