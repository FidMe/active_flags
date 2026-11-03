require 'test_helper'

class ActiveFlags::Handler::FlagMapperTest < ActiveSupport::TestCase
  test 'should authorize and remap flags' do
    authorized_flags = [:hidden, :visible]
    hash_of_flags_to_check = {hidden: true, visible: false, dragonball: '4 on 7'}
    flags = ::ActiveFlags::Handler::FlagMapper.remap(authorized_flags, hash_of_flags_to_check)

    assert_equal 2, flags.count
    assert flags.map{ |flag| flag[:key] }.include?(:hidden)
    assert_not flags.map{ |flag| flag[:key] }.include?(:dragonball)
    assert_instance_of Array, flags
    assert_instance_of Hash, flags.first
  end

  test 'should remap flags sorted by key whatever the given order' do
    keys = ->(flags) { ::ActiveFlags::Handler::FlagMapper.remap([], flags).map { |flag| flag[:key] } }

    assert_equal [:hidden, :pinned, :visible], keys.call(visible: false, hidden: true, pinned: true)
    assert_equal [:hidden, :pinned, :visible], keys.call(pinned: true, visible: false, hidden: true)
  end
end