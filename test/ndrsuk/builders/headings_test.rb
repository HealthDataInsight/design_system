require 'test_helper'
require_relative '../../nhsuk/builders/headings_test'

module DesignSystem
  module Ndrsuk
    module Builders
      # This tests the ndrs headings builder
      class HeadingsTest < ::DesignSystem::Nhsuk::Builders::HeadingsTest
        include DesignSystemHelper

        setup do
          @brand = 'ndrsuk'
          @controller.stubs(:brand).returns(@brand)
        end
      end
    end
  end
end
