require 'minitest/autorun'
require_relative 'text'

class TextTest < MiniTest::Test
  def setup
    @file = File.open('./text.txt', 'r')
  end

  def test_swap
    text = Text.new(@file.read)
    text.swap('a', 'e')
    assert_equal(false, @file.include?('a'))
  end

  def test_word_count
    text = Text.new(@file.read)
    assert_equal 72, text.word_count
  end

  def teardown
    @file.close
  end

end
