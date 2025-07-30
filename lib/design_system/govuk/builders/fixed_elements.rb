# frozen_string_literal: true

require 'design_system/generic/builders/fixed_elements'
require_relative 'elements/breadcrumbs'
require_relative 'elements/headings'

module DesignSystem
  module Govuk
    module Builders
      # This class is used to provide the GOVUK fixed elements builder.
      class FixedElements < ::DesignSystem::Generic::Builders::FixedElements
        include Elements::Breadcrumbs
        include Elements::Headings
      end
    end
  end
end
