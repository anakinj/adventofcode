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

  def regular
    p1 = @players.first
    p2 = @players.last

    while winner.nil?
      p1c = p1.shift
      p2c = p2.shift

      if p1c > p2c
        p1.push(p1c, p2c)
      else
        p2.push(p2c, p1c)
      end

    end
  end

  def recursive
    game = RecursiveGame.new(@players.first, @players.last)

    game.play!

    @players = [game.player1, game.player2]
  end

  def winner
    return nil unless @players.any? { |p| p.size.zero? }

    @players.find { |p| p.size.positive? }
  end

  class RecursiveGame
    attr_reader :player1, :player2, :history1, :history2

    def initialize(player1, player2, game = 1)
      @player1 = player1.dup
      @player2 = player2.dup
      @history = {}
      @round = 0
      @game = game
    end

    def play! # rubocop:disable Metrics/PerceivedComplexity, Metrics/MethodLength
      while !player1.empty? && !player2.empty?
        @round += 1
        if @history[[player1, player2]]
          player2.clear
          next
        end

        @history[[player1.dup, player2.dup]] = true
        p1c = player1.shift
        p2c = player2.shift

        if player1.size >= p1c && player2.size >= p2c
          RecursiveGame.new(player1[0...p1c], player2[0...p2c], @game + 1).tap(&:play!).tap do |subgame|
            if subgame.player1.empty?
              player2.push(p2c, p1c)
            else
              player1.push(p1c, p2c)
            end
            next
          end
        elsif p1c > p2c
          player1.push(p1c, p2c)
        else
          player2.push(p2c, p1c)
        end
      end
    end
  end

  def play(game = :regular)
    send(game)

    winner.reverse.each_with_index.map do |card, index|
      card * (index + 1)
    end.sum
  end
end
