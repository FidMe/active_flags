require 'test_helper'

class ActiveFlags::Handler::FlagMappers::KeyValueMapperTest < ActiveSupport::TestCase
  test 'return a key-value hash in an array of hashes' do
    hash_of_flags = { hidden: true, visible: false }
    array_of_flags = ::ActiveFlags::Handler::FlagMappers::KeyValueMapper.remap(hash_of_flags)

    assert_instance_of Array, array_of_flags
    assert_instance_of Hash, array_of_flags.first
    assert_equal hash_of_flags.keys.sort, array_of_flags.map {|h| h[:key]}.sort
    assert_equal hash_of_flags.values.map(&:to_s).sort, array_of_flags.map {|h| h[:value].to_s}.sort
  end
end
