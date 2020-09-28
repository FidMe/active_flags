class ValueStringifierTest < ActiveSupport::TestCase
  test 'it stringifies the given value correctly' do
    assert_equal 'f', stringify(false)
    assert_equal 'f', stringify('false')
    assert_equal 't', stringify(true)
    assert_equal 't', stringify('true')
    assert_equal 't', stringify(nil)
    assert_equal 'lol', stringify('lol')
  end
end
