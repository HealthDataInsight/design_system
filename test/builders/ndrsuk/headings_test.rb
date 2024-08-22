require 'test_helper'
require_relative '../nhsuk/headings_test'

module DesignSystem
  module Builders
    module Ndrsuk
      # This tests the ndrs headings component
      class HeadingsTest < Nhsuk::HeadingsTest
        include DesignSystemHelper

        setup do
          @brand = 'ndrsuk'
          @controller.stubs(:brand).returns(@brand)
        end
      end
    end
  end
end
