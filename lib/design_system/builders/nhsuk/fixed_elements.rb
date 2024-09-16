# frozen_string_literal: true

require 'design_system/builders/govuk/fixed_elements'
require_relative 'elements/breadcrumbs'

module DesignSystem
  module Builders
    module Nhsuk
      # This class is used to provide the NHSUK fixed elements builder.
      class FixedElements < ::DesignSystem::Builders::Govuk::FixedElements
        include Elements::Breadcrumbs
      end
    end
  end
end
