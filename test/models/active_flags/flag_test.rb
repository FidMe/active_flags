require 'test_helper'

module ActiveFlags
  class FlagTest < ActiveSupport::TestCase
    test 'key is required' do
      flag = Flag.new

      assert flag.invalid?
      assert flag.errors.key?('key')
    end

    test 'value is required' do
      flag = Flag.new

      assert flag.invalid?
      assert flag.errors.key?('value')
    end

    test 'subject is required' do
      flag = Flag.new

      assert flag.invalid?
      assert flag.errors.key?('subject')
    end

    test 'flag belongs to a polymorphic association' do
      user = User.create(first_name: 'Nathan', last_name: 'Huberty')
      flag = Flag.create(key: 'hidden', value: true, subject: user)

      assert_equal User.first, flag.subject
    end

    test "subject_type returns readable subject type" do
      user = User.create(first_name: 'Nathan', last_name: 'Huberty')
      flag = Flag.create(key: 'hidden', value: true, subject: user)

      assert_equal "User", flag.subject_type
    end

    test 'key for a specific user is unique' do
      user = User.create(first_name: 'Nathan', last_name: 'Huberty')
      flag_1 = Flag.create(key: 'hidden', value: true, subject: user)
      flag_2 = Flag.new(key: flag_1.key, value: true, subject: user)

      assert flag_2.invalid?
    end

    test 'different users can have same key' do
      user_1 = User.create(first_name: 'Nathan', last_name: 'Huberty')
      flag_1 = Flag.create(key: 'hidden', value: true, subject: user_1)

      user_2 = User.create(first_name: 'Mauryl', last_name: 'Dovand')
      flag_2 = Flag.new(key: flag_1.key, value: true, subject: user_2)

      assert flag_2.valid?
    end

    test 'removing duplicated flags following production issues' do
      user = User.create(first_name: 'Nathan', last_name: 'Huberty')
      other_user = User.create(first_name: 'Bob', last_name: 'Bob')
      another_user = User.create(first_name: 'John', last_name: 'Doe')

      ActiveRecord::Base.connection.execute("INSERT INTO active_flags_flags (subject_id, subject_type, key, value, created_at, updated_at) VALUES('#{user.id}', 'User', 'visible', 't', '10-01-2019', '10-01-2019')")
      ActiveRecord::Base.connection.execute("INSERT INTO active_flags_flags (subject_id, subject_type, key, value, created_at, updated_at) VALUES('#{user.id}', 'User', 'visible', 't', '10-01-2019', '10-01-2019')")
      ActiveRecord::Base.connection.execute("INSERT INTO active_flags_flags (subject_id, subject_type, key, value, created_at, updated_at) VALUES('#{user.id}', 'User', 'visible', 't', '10-01-2019', '10-01-2019')")
      ActiveRecord::Base.connection.execute("INSERT INTO active_flags_flags (subject_id, subject_type, key, value, created_at, updated_at) VALUES('#{user.id}', 'User', 'visible', 't', '10-01-2019', '10-01-2019')")
      ActiveRecord::Base.connection.execute("INSERT INTO active_flags_flags (subject_id, subject_type, key, value, created_at, updated_at) VALUES('#{other_user.id}', 'User', 'visible', 't', '10-01-2019', '10-01-2019')")
      ActiveRecord::Base.connection.execute("INSERT INTO active_flags_flags (subject_id, subject_type, key, value, created_at, updated_at) VALUES('#{other_user.id}', 'User', 'visible', 't', '10-01-2019', '10-01-2019')")
      ActiveRecord::Base.connection.execute("INSERT INTO active_flags_flags (subject_id, subject_type, key, value, created_at, updated_at) VALUES('#{another_user.id}', 'User', 'visible', 't', '10-01-2019', '10-01-2019')")

      assert_equal 4, ActiveFlags::Flag.where(key: 'visible', subject: user).size
      assert_equal 2, ActiveFlags::Flag.where(key: 'visible', subject: other_user).size
      assert_equal 1, ActiveFlags::Flag.where(key: 'visible', subject: another_user).size

      user.update!(flags: { visible: 'f' })
      other_user.update!(flags: { visible: 'f' })
      another_user.update!(flags: { visible: 'f' })

      assert_equal 1, ActiveFlags::Flag.where(key: 'visible', subject: user).size
      assert_equal 1, ActiveFlags::Flag.where(key: 'visible', subject: other_user).size
      assert_equal 1, ActiveFlags::Flag.where(key: 'visible', subject: another_user).size
    end

  end
end
