require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'renders navigation links correctly with options' do
    nav_item = [
      { label: 'Test Item', path: '/test', options: { method: :delete } }
    ]

    ApplicationController.any_instance.stubs(:navigation_items).returns(nav_item)

    get root_path
    assert_response :success
    assert_select 'nav a[data-method="delete"]', text: 'Test Item'
  end
end
