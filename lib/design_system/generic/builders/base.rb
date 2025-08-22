# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # This is the base class for design system builders.
      class Base
        include DesignSystem::Helpers::CssHelper
        include DesignSystem::Generic::Builders::Concerns::BrandDerivable
        delegate :button_tag, :capture, :content_for, :content_tag, :link_to, :link_to_unless_current, to: :@context

        def initialize(context)
          @context = context
        end
      end
    end
  end
end
