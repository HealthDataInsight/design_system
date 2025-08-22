# frozen_string_literal: true

require 'test_helper'
require 'design_system/generic/builders/concerns/brand_derivable'

module DesignSystem
  module HelloWorld
    module Builders
      class SomeBuilder
        include DesignSystem::Generic::Builders::Concerns::BrandDerivable
      end

      module Concerns
        class BrandDerivableTest < ActionView::TestCase
          test 'test brand name derived from class name' do
            instance = DesignSystem::HelloWorld::Builders::SomeBuilder.new
            assert_equal 'hello_world', instance.brand
          end
        end
      end
    end
  end
end
