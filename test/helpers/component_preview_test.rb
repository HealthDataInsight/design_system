require 'test_helper'
require_relative '../../app/helpers/design_system_helper'
require_relative '../dummy/app/helpers/application_helper'

class ComponentPreviewTest < ActionView::TestCase
  helper DesignSystemHelper
  helper ApplicationHelper

  setup do
    controller.stubs(brand: 'govuk')
  end

  test 'omits the heading by default' do
    result = component_preview(id: 'demo') { '<p>Hi</p>' }

    refute_includes result, 'Custom heading XYZ'
    assert_includes result, 'erb-demo'
    assert_includes result, 'rendered-demo'
  end

  test 'heading: renders the heading at level 3 by default' do
    result = component_preview(heading: 'Custom heading XYZ', id: 'demo') { '<p>Hi</p>' }

    assert_match %r{<h3[^>]*>.*Custom heading XYZ.*</h3>}m, result
  end

  test 'level: overrides the default heading level' do
    result = component_preview(heading: 'Custom heading XYZ', level: 2, id: 'demo') { '<p>Hi</p>' }

    assert_match %r{<h2[^>]*>.*Custom heading XYZ.*</h2>}m, result
    refute_match %r{<h3[^>]*>.*Custom heading XYZ.*</h3>}m, result
  end

  test 'level: has no effect when heading: is omitted' do
    result = component_preview(level: 1, id: 'demo') { '<p>Hi</p>' }

    refute_match(/<h1[^>]*>/, result)
  end

  test 'block content appears in both the source and rendered panes' do
    result = component_preview(id: 'demo') { '<p>Round-trip me</p>' }

    assert_operator result.scan('Round-trip me').size, :>=, 2
  end

  test 'renders brand documentation link once from locale using @component' do
    @component = 'buttons'
    first = component_preview(id: 'demo-a') { '<p>One</p>' }
    second = component_preview(id: 'demo-b') { '<p>Two</p>' }

    assert_includes first, 'View documentation for GOV.UK button'
    assert_includes first, 'design-system.service.gov.uk/components/button'
    refute_includes second, 'View documentation for'
  end

  test 'reference_key overrides @component for locale lookup' do
    @component = 'buttons'
    result = component_preview(reference_key: 'tabs', id: 'demo') { '<p>Hi</p>' }

    assert_includes result, 'View documentation for GOV.UK tabs'
    refute_includes result, 'components/button'
  end

  test 'omits documentation link when locale has no entry for current brand' do
    @component = 'action_link'
    result = component_preview(id: 'demo') { '<p>Hi</p>' }

    refute_includes result, 'View documentation for'
  end
end
