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

  test 'validates age' do
    assistant = Assistant.new

    assistant.age = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:age], error: :blank

    assistant.age = -1
    refute assistant.valid?
    assert_includes assistant.errors.details[:age], value: -1, error: :greater_than_or_equal_to, count: 0

    assistant.age = 1
    assistant.valid?
    assert_empty assistant.errors.details[:age]
  end

  test 'validates colour' do
    assistant = Assistant.new

    assistant.colour = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:colour], error: :blank

    assistant.colour = 'red'
    assistant.valid?
    assert_empty assistant.errors.details[:colour]
  end

  test 'validates description' do
    assistant = Assistant.new

    assistant.description = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:description], error: :blank

    assistant.description = 'a'
    assistant.valid?
    assert_empty assistant.errors.details[:description]
  end

  test 'validates desired filling' do
    assistant = Assistant.new

    assistant.desired_filling = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:desired_filling], error: 'Select at least one filling'

    assistant.desired_filling = []
    refute assistant.valid?
    assert_includes assistant.errors.details[:desired_filling], error: 'Select at least one filling'

    assistant.desired_filling = ['pastrami']
    assistant.valid?
    assert_empty assistant.errors.details[:desired_filling]
    assert_equal ['pastrami'], assistant.read_attribute(:desired_filling)

    assistant.desired_filling = %w[pastrami cheddar]
    assistant.valid?
    assert_empty assistant.errors.details[:desired_filling]
    assert_equal %w[pastrami cheddar], assistant.read_attribute(:desired_filling)
  end

  test 'validates lunch option' do
    assistant = Assistant.new

    assistant.lunch_option = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:lunch_option], error: :blank

    assistant.lunch_option = 'Salad'
    assistant.valid?
    assert_empty assistant.errors.details[:lunch_option]
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

  test 'validates terms agreed' do
    assistant = Assistant.new

    assistant.terms_agreed = false
    refute assistant.valid?
    assert_includes assistant.errors.details[:terms_agreed], error: :accepted

    assistant.terms_agreed = '0'
    refute assistant.valid?
    assert_includes assistant.errors.details[:terms_agreed], error: :accepted

    assistant.terms_agreed = true
    assistant.valid?
    assert_empty assistant.errors.details[:terms_agreed]

    assistant.terms_agreed = '1'
    assistant.valid?
    assert_empty assistant.errors.details[:terms_agreed]
  end

  test 'validates website' do
    assistant = Assistant.new

    assistant.website = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:website], error: :blank

    assistant.website = 'not a website'
    refute assistant.valid?
    assert_includes assistant.errors.details[:website], error: :invalid, value: 'not a website'

    assistant.website = 'http://www.example.com'
    assistant.valid?
    assert_empty assistant.errors.details[:website]
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
