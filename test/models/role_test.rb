require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test 'validates title' do
    role = Role.new

    role.title = nil
    refute role.valid?
    assert_includes role.errors.details[:title], error: :blank

    role.title = ''
    refute role.valid?
    assert_includes role.errors.details[:title], error: :blank

    role.title = 'foo'
    role.valid?
    assert_empty role.errors.details[:title]
  end
end
