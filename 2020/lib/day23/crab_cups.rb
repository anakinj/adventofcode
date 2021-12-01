# frozen_string_literal: true

class CrabCups
  attr_reader :cups

  class Cup
    attr_reader :number

    def initialize(number)
      @number = number
    end

    def next(cup = nil)
      @next = cup unless cup.nil?
      @next
    end

    def numbers_for_next(count)
      current = self.next
      count.times.map do
        current.number.tap { current = current.next }
      end
    end

    def remove_next(count = 3)
      current = self.next
      removed_cups = count.times.map do
        current.tap { current = current.next }
      end

      self.next(current)

      removed_cups
    end
  end

  def initialize(input)
    @cups = input.chars.map(&:to_i)
  end

  def part1!
    deck = play(100)
    cup_one = deck[1]

    numbers = []
    current = cup_one.next

    loop do
      numbers << current.number
      current = current.next
      break if current == cup_one
    end

    numbers.join.to_i
  end

  def part2!
    deck = play(10_000_000, 1_000_000)
    cup_one = deck[1]
    cup_one.next.number * cup_one.next.next.number
  end

  private

  def play(rounds, extra = 0)
    deck, current_cup = arrange_cups_on_deck(extra)

    rounds.times do
      pick_up = current_cup.remove_next(3)
      pick_up_numbers = pick_up.map(&:number)
      destination_number = current_cup.number

      loop do
        destination_number = (destination_number - 2) % deck.size + 1
        break unless pick_up_numbers.include?(destination_number)
      end

      destination_cup = deck[destination_number]
      pick_up.last.next(destination_cup.next)
      destination_cup.next(pick_up.first)

      current_cup = current_cup.next
    end

    deck
  end

  def arrange_cups_on_deck(extra)
    deck = {}
    first_number = cups.shift
    first = prev = Cup.new(first_number)
    deck[first_number] = first

    while (given_number = cups.shift)
      deck[given_number] = prev = prev.next(Cup.new(given_number))
    end

    if extra.positive?
      (deck.size + 1..extra).each do |extra_number|
        deck[extra_number] = prev = prev.next(Cup.new(extra_number))
      end
    end

    prev.next(first)

    [deck, first]
  end
end
