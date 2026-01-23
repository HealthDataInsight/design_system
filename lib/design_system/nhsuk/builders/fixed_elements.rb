# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      # This class is used to provide the NHSUK fixed elements builder.
      class FixedElements < ::DesignSystem::Govuk::Builders::FixedElements
        include Elements::Backlink
        include Elements::Breadcrumbs
      end
    end
  end
end
