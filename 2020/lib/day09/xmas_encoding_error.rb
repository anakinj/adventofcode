# frozen_string_literal: true

module XmasEncodingError
  def self.first_invalid(input, premable_length: 25)
    find_invalids(input.each_line.map(&:to_i), premable_length: premable_length).first
  end

  def self.find_weakness(input, premable_length: 25)
    numbers = input.each_line.map(&:to_i)
    invalid = find_invalids(numbers, premable_length: premable_length).first

    find_sum(invalid, numbers)
  end

  def self.find_sum(the_sum, numbers)
    start_pos = 0
    end_pos = 1
    while (range = numbers[start_pos..end_pos]) && numbers.size >= end_pos
      return range.min + range.max if range.sum == the_sum

      if range.sum > the_sum
        start_pos += 1
        end_pos = start_pos
      end
      end_pos += 1
    end
  end

  def self.find_invalids(numbers, premable_length: 25)
    numbers.each_with_index.each_with_object([]) do |(number, index), invalids|
      next unless index > premable_length - 1

      combos = numbers[((index - premable_length)..index)].combination(2).map(&:sum)

      invalids << number unless combos.include?(number)
    end
  end
end
