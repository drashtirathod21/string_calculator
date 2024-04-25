class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?
    
    # check if numbers start with delimiter
    if numbers.start_with?("//")
      delimiter_line, numbers_without_delimiter = numbers.split("\n", 2)
      negative_numbers = numbers_without_delimiter.scan(/-?\d+/).select { |num| num.to_i.negative? }

      if negative_numbers.any?
        raise ArgumentError, "Negative numbers not allowed: #{negative_numbers.join(', ')}"
      end

      delimiter = delimiter_line[2..-1]
      delimiter_array = numbers_without_delimiter.scan(/[^\d\n]+/).uniq

      # check for invalid delimiter
      if delimiter_array.size > 1
        invalid_delimiter = delimiter_array.reject { |symbol| symbol == "#{delimiter}" }
        invalid_delimiter_index = numbers_without_delimiter.index(invalid_delimiter[0])
        raise ArgumentError, "'#{delimiter}' expected but '#{invalid_delimiter[0]}' found at position #{invalid_delimiter_index}."
      else
        numbers_array = numbers_without_delimiter.split(delimiter)
      end
    else
      numbers_array = numbers.split(/[,\n]+/)

      if numbers.include?(",\n") || numbers_array.include?(" ")
        raise ArgumentError, "Invalid input: comma followed by a new line without a number"
      end
    end

    # check for negative numbers and throw error if any
    negative_numbers = numbers_array.select { |num| num.to_i.negative? }
    if negative_numbers.any?
      raise ArgumentError, "Negative numbers not allowed: #{negative_numbers.join(', ')}"
    end

    numbers_array.map(&:to_i).reduce(:+)
  end
end
