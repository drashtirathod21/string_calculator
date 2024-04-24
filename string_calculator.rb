class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?
    numbers_array = numbers.split(/[,\n]+/)

    if numbers.include?(",\n") || numbers_array.include?(" ")
      raise ArgumentError, "Invalid input: comma followed by a new line without a number"
    end
    numbers_array.map(&:to_i).reduce(:+)
  end
end
