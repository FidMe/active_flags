require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user has flags" do
    user = User.create(first_name: 'Nathan')

    user.update!(flags: [{key: 'coucou', value: 'true'}])

    assert_instance_of ActiveFlags::Flag, user.flags.first
  end

  test "user can create flags without hash keys" do
    user = User.create(last_name: 'Huberty')

    user.update!(flags: [
      {coucou: 'true'},
      {key: 'hello', value: 'true'}
    ])

    assert_equal 2, user.flags.count
  end
end
