# frozen_string_literal: true

require 'test_helper'
require Rails.root.join('../../lib/design_system/builders/concerns/brand_derivable')
require Rails.root.join('../../lib/design_system/builders/govuk/button')
require Rails.root.join('../../lib/design_system/builders/nhsuk/button')

module DesignSystem
  module Builders
    module Concerns
      class BrandDerivableTest < ActionView::TestCase
        test 'test brand name derived from class name' do
          instance = DesignSystem::Builders::Govuk::Button.new(nil)

          assert_equal 'govuk', instance.brand

          instance = DesignSystem::Builders::Nhsuk::Button.new(nil)

          assert_equal 'nhsuk', instance.brand
        end
      end
    end
  end
end
