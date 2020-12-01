file = ARGV[0]

numbers = File.readlines(file).map(&:to_i)
the_numbers = numbers.each_with_object([]) do |first_number, arr|
  numbers.each do |second_number|
    if (first_number + second_number) == 2020
      arr << first_number
      arr << second_number
      break
    end
  end
end.uniq

puts the_numbers.first * the_numbers.last if the_numbers.size == 2

the_numbers = numbers.each_with_object([]) do |first_number, arr|
  numbers.each do |second_number|
    numbers.each do |third_number|
      if (first_number + second_number + third_number) == 2020
        arr << first_number
        arr << second_number
        arr << third_number
        break
      end
    end
  end
end.uniq

puts the_numbers[0] * the_numbers[1] *the_numbers[2] if the_numbers.size == 3
