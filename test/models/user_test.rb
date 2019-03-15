require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user has flags" do
    user = User.create(first_name: 'Nathan')

    user.update!(flags: {visible: true})

    assert_instance_of ActiveFlags::Flag, user.flags_as_collection.first
  end

  test "user can create several flags at a time" do
    user = User.create(last_name: 'Huberty')

    user.update!(flags: {
      visible: true,
      hidden: true
    })

    assert_equal 2, user.flags.count
  end

  test "user can't create flags which are not in the list" do
    user = User.create(last_name: 'Huberty')

    user.update!(flags: {
      visible: true,
      coucou: true
    })

    assert_equal 1, user.flags.count
    assert user.flags[:visible]
  end

  test "user can create flags with keys as strings with arrows" do
    user = User.create(last_name: 'Huberty')

    user.update!(flags: {
      'visible' => true,
      'hidden' => true
    })

    assert_equal 2, user.flags.count
  end

  test "user can update the value of a flag" do
    user = User.create(
      last_name: 'Huberty',
      flags: {
        visible: 'true',
        'hidden' => 'true'
      }
    )
    assert_equal 2, user.flags.count

    user.update!(flags: { hidden: 'false'})
    assert_equal 2, user.flags.count
    assert_equal false, user.flags[:hidden]
  end


  test "user can call its flags by hash or collection" do
    user = User.create(
      last_name: 'Huberty',
      flags: {
        visible: true,
        hidden: true
      }
    )

    assert_not_instance_of ActiveSupport::HashWithIndifferentAccess, user.flags_as_collection
    assert_equal 2, user.flags_as_collection.count

    assert_instance_of ActiveSupport::HashWithIndifferentAccess, user.flags
    assert_equal 2, user.flags.count
    assert user.flags[:visible]
    assert user.flags['visible']
  end
end
