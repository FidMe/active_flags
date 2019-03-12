require 'test_helper'

class FlatTest < ActiveSupport::TestCase
  test "flat can have all possible flags" do
    flat = Flat.create(name: "Nathan's flat")

    flat.update!(flags: {sangoku: 'true', vegeta: 'false'})

    assert_equal 2, flat.flags.count
    assert_instance_of ActiveFlags::Flag, flat.flags_as_collection.first
  end
end
