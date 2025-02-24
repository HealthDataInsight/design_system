require 'test_helper'
require_relative '../../app/helpers/design_system_helper'

class DesignSystemHelperTest < ActionView::TestCase
  def setup
    @registry = DesignSystem::Registry
  end

  def teardown
    @registry = nil
  end

  test 'brand' do
    controller.stubs(brand: 'geoff')

    assert_equal 'geoff', brand
  end

  test 'ds_fixed_elements returns correct instance' do
    brand = 'govuk'
    controller.stubs(brand:)
    assert_equal @registry.builder(brand, 'fixed_elements', self).brand, ds_fixed_elements.brand
    assert_equal @registry.builder(brand, 'FixedElements', self).brand, ds_fixed_elements.brand
  end

  test 'ds_fixed_elements responds to block' do
    block_excuted = false

    controller.stubs(brand: 'govuk')
    ds_fixed_elements do |_ds|
      block_excuted = true
    end
    assert block_excuted
  end

  test 'ds_timeago generates correct HTML' do
    date = Time.now

    result = ds_timeago(date)
    content = I18n.l(date, format: :long)

    assert_includes result, '<time'
    assert_includes result, 'data-controller="timeago"'
    assert_includes result, "data-timeago-datetime-value=\"#{date.iso8601}\""
    assert_includes result, 'data-timeago-refresh-interval-value="60000"'
    assert_includes result, 'data-timeago-add-suffix-value="true"'
    assert_includes result, "title=\"#{content}\""
  end
end
