# frozen_string_literal: true

class RambunctiousRecitation
  attr_reader :starting_numbers

  def initialize(starting_numbers)
    @starting_numbers = starting_numbers.split(',').map(&:to_i)
  end

  def speak_until(turns: 2020)
    spoken_numbers = {}
    last_number = nil

    starting_numbers.each_with_index do |n, i|
      last_number = n
      (spoken_numbers[n] ||= []) << i + 1
    end

    (starting_numbers.size + 1..turns).each do |turn|
      last_number = if Array(spoken_numbers[last_number]).size > 1
                      spoken_numbers[last_number][-1] - spoken_numbers[last_number][-2]
                    else
                      0
                    end
      (spoken_numbers[last_number] ||= []) << turn
    end

    last_number
  end
end
