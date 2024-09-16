# frozen_string_literal: true

require 'design_system/builders/generic/fixed_elements'
require_relative 'elements/breadcrumbs'
require_relative 'elements/headings'

module DesignSystem
  module Builders
    module Govuk
      # This class is used to provide the GOVUK fixed elements builder.
      class FixedElements < ::DesignSystem::Builders::Generic::FixedElements
        include Elements::Breadcrumbs
        include Elements::Headings

      end
    end
  end
end
