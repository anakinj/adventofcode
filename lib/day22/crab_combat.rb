# frozen_string_literal: true

class CrabCombat
  attr_reader :players

  def initialize(input)
    @players = []
    current_player = nil
    input.each_line.map(&:chomp).each do |line|
      next if line.empty?

      if line.include?('Player')
        @players << current_player = []
      else
        current_player << line.to_i
      end
    end
  end

  def play!
    p1 = @players.first
    p2 = @players.last

    while winner.nil?
      p p1
      p p2

      p1c = p1.shift
      p2c = p2.shift

      if p1c > p2c
        p1.push(p1c, p2c)
      else
        p2.push(p2c, p1c)
      end

    end
  end

  def winner
    return nil unless @players.any? { |p| p.size.zero? }

    @players.find { |p| p.size.positive? }
  end

  def winner_total
    play!

    winner.reverse.each_with_index.map do |card, index|
      card * (index + 1)
    end.sum
  end
end
