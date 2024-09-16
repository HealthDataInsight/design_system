require 'test_helper'
require 'design_system/form_builders/ndrsuk'
require_relative 'concerns/govuk_form_builder_testable'

module FormBuilders
  class NdrsukTest < ActionView::TestCase
    include GovukFormBuilderTestable

    def setup
      @brand = 'ndrsuk'
      @builder = DesignSystem::FormBuilders::Ndrsuk
    end
  end
end
