# frozen_string_literal: true

require 'design_system/govuk/builders/fixed_elements'
require_relative 'elements/breadcrumbs'

module DesignSystem
  module Nhsuk
    module Builders
      # This class is used to provide the NHSUK fixed elements builder.
      class FixedElements < ::DesignSystem::Govuk::Builders::FixedElements
        include Elements::Breadcrumbs
      end
    end
  end
end
