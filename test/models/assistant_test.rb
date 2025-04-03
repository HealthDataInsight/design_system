require 'test_helper'

class AssistantTest < ActiveSupport::TestCase
  test 'validates title' do
    assistant = Assistant.new

    assistant.title = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:title], error: :blank

    assistant.title = ''
    refute assistant.valid?
    assert_includes assistant.errors.details[:title], error: :blank

    assistant.title = 'a'
    refute assistant.valid?
    assert_includes assistant.errors.details[:title], error: :too_short, count: 2

    assistant.title = 'foo'
    assistant.valid?
    assert_empty assistant.errors.details[:title]
  end

  test 'validates department' do
    assistant = Assistant.new

    assistant.department = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:department_id], error: :blank

    assistant.department = departments(:marketing)
    assistant.valid?
    assert_empty assistant.errors.details[:department_id]
  end

  test 'validates password' do
    assistant = Assistant.new

    assistant.password = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:password], error: :blank

    assistant.password = ''
    refute assistant.valid?
    assert_includes assistant.errors.details[:password], error: :blank

    assistant.password = 'foo'
    refute assistant.valid?
    assert_includes assistant.errors.details[:password], error: :too_short, count: 8

    assistant.password = 'password'
    assistant.valid?
    assert_empty assistant.errors.details[:password]
  end

  test 'validates role' do
    assistant = Assistant.new

    assistant.role = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:role_id], error: :blank

    assistant.role = roles(:admin)
    assistant.valid?
    assert_empty assistant.errors.details[:role_id]
  end

  test 'validates date of birth' do
    assistant = Assistant.new

    assistant.date_of_birth = nil
    assistant.valid?
    assert_empty assistant.errors.details[:date_of_birth]

    assistant.date_of_birth = Date.today
    refute assistant.valid?
    assert_includes assistant.errors.details[:date_of_birth], error: 'Your date of birth must be in the past'

    assistant.date_of_birth = Date.yesterday
    assistant.valid?
    assert_empty assistant.errors.details[:date_of_birth]
  end

  test 'validates phone or email presence' do
    assistant = Assistant.new

    assistant.phone = nil
    assistant.email = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:base], error: 'Enter a telephone number or email address'

    assistant.phone = '1234567890'
    assistant.valid?
    assert_empty assistant.errors.details[:base]

    assistant.phone = nil
    assistant.email = 'test@example.com'
    assistant.valid?
    assert_empty assistant.errors.details[:base]
  end
end
