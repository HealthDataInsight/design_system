# frozen_string_literal: true

module DesignSystem
  module Builders
    module Generic
      # This is the base class for design system builders.
      class Base
        include CssHelper
        delegate :capture, :content_for, :content_tag, :link_to, :link_to_unless_current, :button_tag, to: :@context

        def initialize(context)
          @context = context
        end

        def brand
          self.class.name.split('::')[2].underscore
        end
      end
    end
  end
end
