# frozen_string_literal: true

class CrabCups
  attr_reader :cups

  def initialize(input)
    @cups = input.chars.map(&:to_i)
  end

  def play!
    current_cup = cups.first
    100.times do |_i|
      current_index   = cups.index(current_cup)
      picked_up_cups  = pick_up(current_index + 1)
      destination_cup = current_cup - 1

      until cups.include?(destination_cup)
        destination_cup -= 1
        destination_cup = (picked_up_cups + cups).max if destination_cup < 1
      end

      destination_index = cups.index(destination_cup)

      cups.insert(destination_index + 1, *picked_up_cups)
      current_index = cups.index(current_cup) + 1
      current_index = 0 if current_index >= cups.size
      current_cup = cups[current_index]
    end

    index_of_one = cups.index(1)
    (cups[index_of_one + 1..] + cups[0, index_of_one]).join.to_i
  end

  def pick_up(from, amount = 3)
    pick = []
    amount.times do
      from = 0 if cups.size <= from
      pick << cups[from]
      from += 1
    end
    pick.each { |p| cups.delete(p) }
    pick
  end
end
