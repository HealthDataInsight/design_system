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

    assistant.title = 'foo'
    assistant.valid?
    assert_empty assistant.errors.details[:title]
  end

  test 'validates department' do
    assistant = Assistant.new

    assistant.department = nil
    refute assistant.valid?
    assert_includes assistant.errors.details[:department], error: :blank

    assistant.department = departments(:marketing)
    assistant.valid?
    assert_empty assistant.errors.details[:department]
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
    assistant.valid?
    assert_empty assistant.errors.details[:password]
  end
end
