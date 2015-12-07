require 'test_helper'
require 'foo'

class FooTest < Minitest::Test
  def setup
    @foo = Foo.new
  end

  def test_hello
    assert_equal 'hello', @foo.hello
  end

  def test_bye
    assert_equal 'bye', @foo.bye
  end
end