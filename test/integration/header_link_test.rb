require 'test_helper'

class HeaderLinkTest < ActionDispatch::IntegrationTest
  test 'nhsuk header logo links to the default root path' do
    get root_path(brand: 'nhsuk')

    assert_response :success
    assert_select 'a.nhsuk-header__service-logo[href=?]', root_path
  end

  test 'govuk header logo links to the default root path' do
    get root_path(brand: 'govuk')

    assert_response :success
    assert_select 'a.govuk-header__link--homepage[href=?]', root_path
  end

  test 'nhsuk header logo honours an overridden ds_root_path' do
    ApplicationController.any_instance.stubs(:ds_root_path).returns('/custom-home')

    get root_path(brand: 'nhsuk')

    assert_response :success
    assert_select 'a.nhsuk-header__service-logo[href="/custom-home"]'
  end

  test 'govuk header logo honours an overridden ds_root_path' do
    ApplicationController.any_instance.stubs(:ds_root_path).returns('/custom-home')

    get root_path(brand: 'govuk')

    assert_response :success
    assert_select 'a.govuk-header__link--homepage[href="/custom-home"]'
  end
end
