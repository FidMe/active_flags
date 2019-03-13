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
  end
end
