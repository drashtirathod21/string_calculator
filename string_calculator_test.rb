require 'minitest/autorun'
require_relative 'string_calculator'

class StringCalculatorTest < Minitest::Test
  def setup
    @calculator = StringCalculator.new
  end

  def test_empty_string_returns_zero
    assert_equal 0, @calculator.add("")
  end

  def test_single_number_returns_number
    assert_equal 1, @calculator.add("1")
  end

  def test_two_numbers_return_sum
    assert_equal 3, @calculator.add("1,2")
  end

  def test_any_amount_of_numbers_return_sum
    assert_equal 6, @calculator.add("1,2,3")
    assert_equal 10, @calculator.add("1,2,3,4")
    assert_equal 15, @calculator.add("1,2,3,4,5")
  end

  def test_numbers_with_spaces
    assert_equal 10, @calculator.add("1,  2, 3, 4")
  end

  def test_new_lines_between_numbers
    assert_equal 6, @calculator.add("1\n2,3")
  end

  def test_invalid_input_comma_followed_by_new_line
    assert_raises(ArgumentError) { @calculator.add("1,\n") }
  end
end
