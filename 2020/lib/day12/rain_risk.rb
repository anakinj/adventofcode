# frozen_string_literal: true

module RainRisk
  INSTRUCTION = /(?<direction>[NESWLRF])(?<steps>\d+)/.freeze
  DIRECTIONS  = %w[N E S W].freeze

  module SimpleShipNavigation
    def facing
      @facing ||= 'E'
    end

    def move_one(direction:, steps:)
      case direction
      when 'F'
        move(facing, steps)
      when 'L', 'R'
        turn(direction, steps)
      else
        move(direction, steps)
      end
    end

    def turn(direction, degrees)
      count = degrees / 90

      current = DIRECTIONS.index(facing)

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

  module WaypointShipNavigation
    def move_one(direction:, steps:)
      waypoint.move_one(direction: direction, steps: steps)

      return unless direction == 'F'

      @north += steps * waypoint.north
      @east  += steps * waypoint.east
    end
  end

  class NavalObject
    attr_accessor :north, :east

    def initialize(north = 0, east = 0)
      @north  = north
      @east   = east
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
  end

  class Waypoint < NavalObject
    def move_one(direction:, steps:)
      case direction
      when 'L', 'R'
        rotate(direction, steps)
      else
        move(direction, steps)
      end
    end

    def rotate(direction, steps)
      (steps / 90).times do
        rotate_around(direction)
      end
    end

    def rotate_around(direction)
      if direction == 'R'
        n = @north
        @north = @east * -1
        @east = n
      else
        e = @east
        @east = @north * -1
        @north = e
      end
    end
  end

  class Ship < NavalObject
    include SimpleShipNavigation

    def to_s
      '🚢'
    end

    def manhattan_position
      north.abs + east.abs
    end

    def navigate(instructions)
      instructions.each do |instruction|
        match = instruction.match(INSTRUCTION)
        move_one(direction: match[:direction],
                 steps: match[:steps].to_i)
        yield(self) if block_given?
      end
    end
  end

  class WaypointShip < Ship
    include WaypointShipNavigation

    attr_reader :waypoint

    def initialize
      @waypoint = Waypoint.new(1, 10)
      super
    end
  end

  def self.manhattan_position_for(type, input)
    type.new.tap { |ship| ship.navigate(input.each_line) }.manhattan_position
  end
end
