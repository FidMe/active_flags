require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user has flags" do
    user = User.create(first_name: 'Nathan')

    user.update!(flags: {visible: 'true'})

    assert_instance_of ActiveFlags::Flag, user.flags.first
  end

  test "user can create several flags at a time" do
    user = User.create(last_name: 'Huberty')

    user.update!(flags: {
      visible: 'true',
      hidden: 'true'
    })

    assert_equal 2, user.flags.count
  end

  test "user can't create flags which are not in the list" do
    user = User.create(last_name: 'Huberty')

    user.update!(flags: {
      visible: 'true',
      coucou: 'true'
    })

    assert_equal 1, user.flags.count
    assert_equal 'visible', user.flags.first[:key]
  end

  test "user can create flags with keys as strings with arrows" do
    user = User.create(last_name: 'Huberty')

    user.update!(flags: {
      'visible' => 'true',
      'hidden' => 'true'
    })

    assert_equal 2, user.flags.count
  end
end
