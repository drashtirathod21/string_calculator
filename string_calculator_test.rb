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
    assert_raises(ArgumentError) { @calculator.add("1, \n, 2") }
  end

  def test_custom_delimiter
    assert_equal 3, @calculator.add("//;\n1;2")
    assert_equal 6, @calculator.add("//|\n1|2|3")
    assert_equal 5, @calculator.add("//sep\n2sep3")
  end

  def test_invalid_custom_delimiter
    exception = assert_raises(ArgumentError) { @calculator.add("//|\n1|2,3") }
    assert_equal "'|' expected but ',' found at position 3.", exception.message
  end

  def test_negative_number
    error = assert_raises(ArgumentError) { @calculator.add("-1,2") }
    assert_equal "Negative numbers not allowed: -1", error.message
  end

  def test_multiple_negative_numbers
    error = assert_raises(ArgumentError) { @calculator.add("2,-4,-5") }
    assert_equal "Negative numbers not allowed: -4, -5", error.message
  end

  def test_negative_number_with_delimiter
    error = assert_raises(ArgumentError) { @calculator.add("//;\n1;-2;3") }
    assert_equal "Negative numbers not allowed: -2", error.message
  end

  def test_multiple_negative_numbers_with_delimiter
    error = assert_raises(ArgumentError) { @calculator.add("//|\n1|-2,3,-4") }
    assert_equal "Negative numbers not allowed: -2, -4", error.message
  end
end
