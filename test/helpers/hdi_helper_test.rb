require 'test_helper'

class HdiHelperTest < ActionView::TestCase
  include HdiHelper

  setup do
    @item = { label: 'Home', path: root_path, options: { data: { test: 'foo' }, icon: 'home' } }
  end

  test 'active sidebar_navigation_svg' do
    stubs(:current_page?).returns(true)

    @output_buffer = ActionView::OutputBuffer.new(hdi_sidebar_navigation_svg(@item))
    assert_select 'a[data-test="foo"].flex.text-indigo-600', /Home\z/ do
      assert_select 'a[href=?]', root_path
      assert_select 'img[src=?]', '/design_system/static/heroicons-2.1.5/icon-home.svg'
    end
  end

  test 'inactive sidebar_navigation_svg' do
    stubs(:current_page?).returns(false)

    @output_buffer = ActionView::OutputBuffer.new(hdi_sidebar_navigation_svg(@item))
    assert_select 'a[data-test="foo"].flex.text-gray-700', /Home\z/ do
      assert_select 'a[href=?]', root_path
      assert_select 'img[src=?]', '/design_system/static/heroicons-2.1.5/icon-home.svg'
    end
  end
end
