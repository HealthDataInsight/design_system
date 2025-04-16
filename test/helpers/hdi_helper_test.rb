require 'test_helper'

class HdiHelperTest < ActionView::TestCase
  include HdiHelper

  setup do
    @item = { label: 'Home', path: root_path, options: { data: { test: 'foo' }, icon: 'home' } }
  end

  test 'active sidebar_navigation_svg' do
    stubs(:current_page?).returns(true)

    @output_buffer = ActionView::OutputBuffer.new(hdi_sidebar_navigation_svg(@item))
    assert_select "a[data-test='foo'].hdi-icon-link__active", /Home\z/ do
      assert_select 'a[href=?]', root_path
      assert_select 'img[src=?]', '/design_system/static/hdi-frontend-0.10.0/icons/icon-home.svg'
    end
  end

  test 'inactive sidebar_navigation_svg' do
    stubs(:current_page?).returns(false)

    @output_buffer = ActionView::OutputBuffer.new(hdi_sidebar_navigation_svg(@item))
    assert_select "a[data-test='foo'].hdi-icon-link", /Home\z/ do
      assert_select 'a[href=?]', root_path
      assert_select 'img[src=?]', '/design_system/static/hdi-frontend-0.10.0/icons/icon-home.svg'
    end
  end
end
