# frozen_string_literal: true

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
