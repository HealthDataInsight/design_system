# frozen_string_literal: true

require 'test_helper'

module DesignSystem
  module HelloWorld
    module Builders
      class SomeBuilder
        include DesignSystem::BrandDerivable
      end
    end
  end

  class BrandDerivableTest < ActionView::TestCase
    test 'test brand name derived from class name' do
      instance = DesignSystem::HelloWorld::Builders::SomeBuilder.new
      assert_equal 'hello_world', instance.brand
    end
  end
end
