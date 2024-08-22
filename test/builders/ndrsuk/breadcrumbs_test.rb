# frozen_string_literal: true

require 'test_helper'
require_relative '../nhsuk/breadcrumbs_test'

module DesignSystem
  module Builders
    module Ndrsuk
      # This tests the ndrsuk breadcrumbs component
      class BreadcrumbsTest < Nhsuk::BreadcrumbsTest
        include DesignSystemHelper

        setup do
          @brand = 'ndrsuk'
          @controller.stubs(:brand).returns(@brand)
        end
      end
    end
  end
end
