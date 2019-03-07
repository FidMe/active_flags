require 'test_helper'

class ActiveFlags::Handler::FlagMapperTest < ActiveSupport::TestCase
  test 'should create a flag associated to the resource' do
    resource = User.create(first_name: 'Nathan', last_name: 'Huberty')
    flag_attributes = { key: 'hidden', value: 'true'}
    ::ActiveFlags::Handler::FlagBuilder.new(resource, flag_attributes).save

    assert_equal 1, resource.flags.count
    assert_equal resource, ActiveFlags::Flag.last.subject
  end
end