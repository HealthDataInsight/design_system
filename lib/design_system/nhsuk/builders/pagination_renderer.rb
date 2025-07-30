# frozen_string_literal: true

module DesignSystem
  module Nhsuk
    module Builders
      # This class is used to provide will_paginate renderer for NHS UK.
      class PaginationRenderer < ::DesignSystem::Generic::Builders::PaginationRenderer
        # NHSUK doesn't show page number links so overriding it here
        def prepare(collection, options, template)
          options.merge!({ page_links: false })
          super
        end
      end
    end
  end
end
