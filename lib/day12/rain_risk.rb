# frozen_string_literal: true

module RainRisk
  INSTRUCTION = /(?<direction>[NESWLRF])(?<steps>\d+)/.freeze
  class Ship
    attr_reader :north, :east

    DIRECTIONS = %w[N E S W].freeze
    def initialize
      @facing = 'E'
      @north  = 0
      @east   = 0
    end

    def navigate(instructions)
      instructions.each do |instruction|
        move_one(instruction)
        yield(self) if block_given?
      end
    end

    def to_s
      '🚢'
    end

    def move_one(instruction)
      match = instruction.match(INSTRUCTION)
      steps = match[:steps].to_i
      case match[:direction]
      when 'F'
        move(@facing, steps)
      when 'L', 'R'
        turn(match[:direction], steps)
      else
        move(match[:direction], steps)
      end
    end

    def move(direction, steps)
      case direction
      when 'N'
        @north += steps
      when 'E'
        @east += steps
      when 'S'
        @north -= steps
      when 'W'
        @east -= steps
      end
    end

    def turn(direction, degrees)
      count = degrees / 90

      current = DIRECTIONS.index(@facing)

      if direction == 'L'
        current -= count
      else
        current += count
      end

      current -= 4 while current > 3
      current += 4 while current.negative?

      @facing = DIRECTIONS[current]
    end
  end

  def self.manhattan_position(input)
    ship = Ship.new
    ship.navigate(input.each_line)
    ship.north.abs + ship.east.abs
  end
end
