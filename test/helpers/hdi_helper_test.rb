require 'test_helper'

class HdiHelperTest < ActionView::TestCase
  include HdiHelper

  test 'nav_item_active?' do
    # should be active with callable active
    assert nav_item_active?({ options: { active: -> { true } } })

    # should be active with matching controller and inactive otherwise
    @controller.params = { controller: 'pages' }
    assert nav_item_active?({ options: { controller: 'pages' } })
    assert_not nav_item_active?({ options: { controller: 'users' } })

    # should not be active with blank controller
    assert_not nav_item_active?({ options: { controller: '' } })
  end

  test 'sidebar_navigation_svg' do
    @output_buffer = ActionView::OutputBuffer.new(
      hdi_sidebar_navigation_svg('Home', root_path, true, data: { test: 'foo' }, icon: 'home') do
        content_tag('stroke-linecap' => 'round', 'stroke-linejoin' => 'round')
      end
    )
    assert_select 'a[data-test="foo"].flex.text-indigo-600', /Home\z/ do
      assert_select 'a[href=?]', root_path
      assert_select 'img[src=?]', '/design_system/heroicons-2.1.5/icon-home.svg'
    end

    @output_buffer = ActionView::OutputBuffer.new(
      hdi_sidebar_navigation_svg('Home', root_path, false, data: { test: 'foo' }, icon: 'home') do
        content_tag('stroke-linecap' => 'round', 'stroke-linejoin' => 'round')
      end
    )
    assert_select 'a[data-test="foo"].flex.text-gray-700', /Home\z/ do
      assert_select 'a[href=?]', root_path
      assert_select 'img[src=?]', '/design_system/heroicons-2.1.5/icon-home.svg'
    end
  end
end
