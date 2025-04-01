require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  test 'validates title' do
    department = Department.new

    department.title = nil
    refute department.valid?
    assert_includes department.errors.details[:title], error: :blank

    department.title = ''
    refute department.valid?
    assert_includes department.errors.details[:title], error: :blank

    department.title = 'foo'
    department.valid?
    assert_empty department.errors.details[:title]
  end
end
