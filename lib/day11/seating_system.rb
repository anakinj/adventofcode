# frozen_string_literal: true

module SeatingSystem
  class Item
    attr_accessor :room, :row, :col

    DIRECTIONS = %i[west east north south southwest northwest northeast southeast].freeze

    def initialize(row, col)
      @row = row
      @col = col
    end

    def neighbours(type)
      DIRECTIONS.map do |direction|
        first_item_to(direction, type)
      end.compact
    end

    def first_item_to(direction, cls)
      r = row
      c = col

      loop do
        c -= 1 if %i[west northwest southwest].include?(direction)
        c += 1 if %i[east northeast southeast].include?(direction)
        r -= 1 if %i[north northwest northeast].include?(direction)
        r += 1 if %i[south southwest southeast].include?(direction)

        item = room.item_at(r, c)

        return item if item.nil? || item.is_a?(cls)
      end
    end

    def prepare(*_args)
      false
    end

    def change; end
  end

  class Seat < Item
    EMPTY = 'L'
    OCCUPIED = '#'

    def initialize(row, col, state)
      @state = state
      super(row, col)
    end

    def occupied?
      @state == OCCUPIED
    end

    def empty?
      @state == EMPTY
    end

    def prepare(adjacent, tolerance)
      if empty? && neighbours(adjacent).none?(&:occupied?)
        @next_state = OCCUPIED
        return true
      elsif occupied? && neighbours(adjacent).count(&:occupied?) >= tolerance
        @next_state = EMPTY
        return true
      end
      false
    end

    def change
      @state = @next_state if @next_state
      @next_state = nil
    end

    def to_s
      @state
    end
  end

  class Floor < Item
    def occupied?
      false
    end

    def to_s
      '.'
    end
  end

  class Room
    attr_reader :items

    def initialize
      @items = []
    end

    def add_item(item, row, col)
      (items[row] ||= [])[col] = item
      item.room = self
    end

    def item_at(row, col)
      return nil if row.negative? || col.negative?

      Array(items[row])[col]
    end

    def all_items
      items.flatten
    end

    def prepare(adjacent, tolerance)
      all_items.map { |item| item.prepare(adjacent, tolerance) }.any?
    end

    def change
      all_items.each(&:change)
    end

    def layout
      items.map do |row|
        row.map(&:to_s).join
      end.join("\n")
    end

    def change_until_stable(adjacent, tolerance)
      while prepare(adjacent, tolerance)
        change
        yield(self) if block_given?
      end
    end
  end

  class Parser
    def initialize(input)
      @input = input
      @room = Room.new
    end

    def fill_room
      @input.each_line.with_index do |line, row|
        line.chars.each_with_index do |char, col|
          add_item(char, row, col)
        end
      end
      @room
    end

    def add_item(char, row, col)
      item = create_item(char, row, col)
      return if item.nil?

      @room.add_item(item, row, col)
    end

    def create_item(char, row, col)
      case char
      when '#', 'L'
        Seat.new(row, col, char)
      when '.'
        Floor.new(row, col)
      end
    end
  end

  def self.occupied(input, adjacent = Item, tolerance = 4)
    room = Parser.new(input).fill_room
    room.change_until_stable(adjacent, tolerance)
    room.all_items.count(&:occupied?)
  end
end
