require 'test_helper'
require_relative '../../app/helpers/design_system_helper'
require_relative '../dummy/app/helpers/application_helper'

class ComponentPreviewTest < ActionView::TestCase
  helper DesignSystemHelper
  helper ApplicationHelper

  setup do
    controller.stubs(brand: 'govuk')
  end

  test 'omits the heading when locale has no entry for key' do
    result = component_preview(:nonexistent_preview) { '<p>Hi</p>' }

    refute_match %r{<h3[^>]*>.*</h3>}m, result
    assert_includes result, 'erb-nonexistent-preview'
    assert_includes result, 'rendered-nonexistent-preview'
  end

  test 'heading from locale renders at level 3' do
    result = component_preview(:buttons_primary) { '<p>Hi</p>' }

    assert_match %r{<h3[^>]*>.*Primary button.*</h3>}m, result
    refute_match %r{<h2[^>]*>.*Primary button.*</h2>}m, result
  end

  test 'derives id from locale key' do
    result = component_preview(:action_link_text) { '<p>Hi</p>' }

    assert_includes result, 'erb-action-link-text'
    assert_includes result, 'rendered-action-link-text'
  end

  test 'defaults to @component for locale key and id' do
    @component = 'action_link'
    result = component_preview { '<p>Hi</p>' }

    assert_includes result, 'erb-action-link'
  end

  test 'block content appears in both the source and rendered panes' do
    result = component_preview(:buttons_primary) { '<p>Round-trip me</p>' }

    assert_operator result.scan('Round-trip me').size, :>=, 2
  end

  test 'renders documentation link when locale has reference_url' do
    result = component_preview(:buttons_start) { '<p>One</p>' }

    assert_includes result, 'View documentation'
    assert_includes result, 'design-system.service.gov.uk/components/button'
  end

  test 'omits documentation link when locale has no reference_url' do
    result = component_preview(:action_link_text) { '<p>Hi</p>' }

    refute_includes result, 'View documentation'
  end
end
