# frozen_string_literal: true

require 'test_helper'
require_relative '../../nhsuk/builders/breadcrumbs_test'

module DesignSystem
  module Ndrsuk
    module Builders
      # This tests the ndrsuk breadcrumbs builder
      class BreadcrumbsTest < ::DesignSystem::Nhsuk::Builders::BreadcrumbsTest
        include DesignSystemHelper

        setup do
          @brand = 'ndrsuk'
          @controller.stubs(:brand).returns(@brand)
        end
      end
    end
  end
end
