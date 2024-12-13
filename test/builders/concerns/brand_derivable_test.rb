# frozen_string_literal: true

require 'test_helper'
require Rails.root.join('../../lib/design_system/builders/concerns/brand_derivable')

module DesignSystem
  module Builders
    class HelloWorld
      include DesignSystem::Builders::Concerns::BrandDerivable
    end

    module Concerns
      class BrandDerivableTest < ActionView::TestCase
        test 'test brand name derived from class name' do
          instance = DesignSystem::Builders::HelloWorld.new
          assert_equal 'hello_world', instance.brand
        end
      end
    end
  end
end
