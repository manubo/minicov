require 'test_helper'
require 'bar'

class BarTest < Minitest::Test
  def setup
    @bar = Bar.new
  end

  def test_nice
    assert_equal 'nice', @bar.nice
  end

  def test_peace
    assert_equal 'peace', @bar.peace
  end
end