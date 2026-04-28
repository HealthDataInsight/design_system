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

    refute_match %r{<h1[^>]*>}, result
  end

  test 'block content appears in both the source and rendered panes' do
    result = component_preview(id: 'demo') { '<p>Round-trip me</p>' }

    assert_operator result.scan('Round-trip me').size, :>=, 2
  end
end
