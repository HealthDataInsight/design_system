require 'test_helper'

class AssistantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assistant = assistants(:one)
  end

  test 'setup' do
    assert_kind_of Assistant, @assistant
  end

  test 'should get index' do
    get assistants_url
    assert_response :success
  end

  test 'should get new' do
    get new_assistant_url
    assert_response :success
  end

  test 'should create assistant' do
    assert_difference('Assistant.count') do
      post assistants_url, params: { assistant: { title: 'Foo', department_id: 1, role_id: 1, email: 'bar@example.com', password: 'password' } }
    end

    assert_redirected_to assistant_url(Assistant.last)
  end

  test 'should show assistant' do
    get assistant_url(@assistant)
    assert_response :success
  end

  test 'should get edit' do
    get edit_assistant_url(@assistant)
    assert_response :success
  end

  test 'should update assistant' do
    patch assistant_url(@assistant), params: { assistant: { title: 'Bar' } }
    assert_redirected_to assistant_url(@assistant)
  end

  test 'should destroy assistant' do
    assert_difference('Assistant.count', -1) do
      delete assistant_url(@assistant)
    end

    assert_redirected_to assistants_url
  end
end
