# frozen_string_literal: true

class RambunctiousRecitation
  attr_reader :starting_numbers, :spoken_numbers

  def initialize(starting_numbers)
    @starting_numbers = starting_numbers.split(',').map(&:to_i)
    @spoken_numbers = {}
  end

  def speak_until(turns: 2020)
    last_number = nil

    starting_numbers.each_with_index do |n, i|
      last_number = n
      (spoken_numbers[n] ||= []) << i + 1
    end

    (starting_numbers.size + 1..turns).each do |turn|
      last_number = next_number(last_number)
      (spoken_numbers[last_number] ||= []) << turn
    end

    last_number
  end

  def next_number(last_number)
    if (prev_numbers = Array(spoken_numbers[last_number])).size > 1
      prev_numbers[-1] - prev_numbers[-2]
    else
      0
    end
  end
end
