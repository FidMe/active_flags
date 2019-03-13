require 'test_helper'

class ActiveFlags::Handler::FlagMappers::AuthorizerTest < ActiveSupport::TestCase
  test 'should authorize every flags if no authorized_flags passed' do
    authorized_flags = []
    flags_to_check = {hidden: true, magic: false}
    flags = ::ActiveFlags::Handler::FlagMappers::Authorizer.authorize(authorized_flags, flags_to_check)

    assert_equal 2, flags.count
  end

  test 'should authorize only passed flags' do
    authorized_flags = [:hidden, :visible]
    flags_to_check = {hidden: true, magic: false}
    flags = ::ActiveFlags::Handler::FlagMappers::Authorizer.authorize(authorized_flags, flags_to_check)

    assert_equal 1, flags.count
    assert flags.has_key?(:hidden)
    assert_not flags.has_key?(:magic)
  end
end
