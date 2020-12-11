# frozen_string_literal: true

module SeatingSystem
  class Item
    attr_accessor :room, :row, :col

    def initialize(row, col)
      @row = row
      @col = col
    end

    def neighbours
      [west, east, north, south,
       southwest, northwest, northeast, southeast].compact
    end

    def west
      room.item_at(row, col - 1)
    end

    def east
      room.item_at(row, col + 1)
    end

    def north
      room.item_at(row - 1, col)
    end

    def south
      room.item_at(row + 1, col)
    end

    def southwest
      room.item_at(row + 1, col - 1)
    end

    def northwest
      room.item_at(row - 1, col - 1)
    end

    def northeast
      room.item_at(row - 1, col + 1)
    end

    def southeast
      room.item_at(row + 1, col + 1)
    end

    def prepare
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

    def prepare
      if empty? && neighbours.none?(&:occupied?)
        @next_state = OCCUPIED
        return true
      elsif occupied? && neighbours.count(&:occupied?) >= 4
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

    def prepare
      all_items.map(&:prepare).any?
    end

    def change
      all_items.each(&:change)
    end

    def to_s
      items.map do |row|
        row.map(&:to_s).join
      end.join("\n")
    end

    def change_until_stable
      change while prepare
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

  def self.occupied(input)
    room = Parser.new(input).fill_room
    room.change_until_stable
    room.all_items.count(&:occupied?)
  end
end
