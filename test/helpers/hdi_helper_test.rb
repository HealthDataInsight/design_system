require 'test_helper'

class HdiHelperTest < ActionView::TestCase
  include HdiHelper

  test 'sidebar_navigation_svg' do
    @output_buffer = ActionView::OutputBuffer.new(
      hdi_sidebar_navigation_svg('Home', root_path, true, data: { test: 'foo' }) do
        content_tag(:path, 'stroke-linecap' => 'round', 'stroke-linejoin' => 'round')
      end
    )
    assert_select 'a[data-test="foo"].flex.text-indigo-600', /Home\z/ do
      assert_select 'svg' do
        assert_select 'path'
      end
    end

    @output_buffer = ActionView::OutputBuffer.new(
      hdi_sidebar_navigation_svg('Home', root_path, false, data: { test: 'foo' }) do
        content_tag(:path, 'stroke-linecap' => 'round', 'stroke-linejoin' => 'round')
      end
    )
    assert_select 'a[data-test="foo"].flex.text-gray-700', /Home\z/ do
      assert_select 'svg' do
        assert_select 'path'
      end
    end
  end
end
