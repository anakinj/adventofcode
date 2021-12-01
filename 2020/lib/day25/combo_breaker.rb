# frozen_string_literal: true

class ComboBreaker
  MAGIC_NUMBER = 20_201_227

  attr_reader :card_number, :door_number

  def initialize(input)
    @card_number, @door_number = input.each_line.map(&:to_i)
  end

  def part1!
    transformer(1, door_number, resolve_loopsize(card_number))
  end

  private

  def resolve_loopsize(number)
    loopsize = 0
    value    = 1
    while value != number
      value = transformer(value, 7)
      loopsize += 1
    end
    loopsize
  end

  def transformer(value, subject, loops = 1)
    loops.times do
      value = (value * subject) % MAGIC_NUMBER
    end
    value
  end
end
