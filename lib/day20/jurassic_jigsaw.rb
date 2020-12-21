# frozen_string_literal: true

module JurassicJigsaw
  class Tile
    attr_reader :id, :top, :left, :right, :bottom, :matches, :content

    ID_REGEX = /Tile (?<id>\d+):/.freeze

    def to_s
      tile_input
    end

    def initialize(tile_input, id = nil)
      @tile_input = tile_input
      @lines   = []
      @left    = []
      @right   = []
      @content = []
      @id      = id

      tile_input.each do |line|
        next if line.empty?

        if (match = ID_REGEX.match(line))
          @id = match[:id].to_i
        else
          @top ||= line
          @left    << line.chars[0]
          @content << line.chars
          @right   << line.chars[-1]
          @lines   << line
          @bottom  = line
        end
      end

      @left  = @left.join
      @right = @right.join
    end

    def variants
      variants = [rotate(@content)]
      [@content, rotate(@content)].each do |content|
        variants << self.class.new(content.reverse.map(&:join), id)
        variants << self.class.new(content.reverse.map(&:reverse).map(&:join), id)
        variants << self.class.new(content.map(&:reverse).map(&:join), id)
      end
    end

    def rotate(content)
      (0...content.length).map { |i| content.map { |row| row[i] } }
    end

    def neighbour(on)
      case on
      when :left
        @matches[left]
      when :right
        @matches[right]
      when :top
        @matches[top]
      when :bottom
        @matches[bottom]
      end
    end

    def combinations
      [
        right,
        left,
        top,
        bottom,
        right.reverse,
        left.reverse,
        top.reverse,
        bottom.reverse
      ]
    end

    def add_to(hash)
      combinations.each do |combo|
        (hash[combo] ||= []) << self
      end
    end

    def resolve_matches(lookup)
      @matches = {}
      combinations.each do |combo|
        lookup[combo].each do |friend|
          next if friend == self

          @matches[combo] = friend
        end
      end
    end
  end

  def self.multiply_corners(input)
    tiles = parse_tiles(input.each_line.map(&:chomp))

    corners, = resolve_tiles(tiles)

    corners.map(&:id).inject(&:*)
  end

  def self.seamonster(input)
    tiles = parse_tiles(input.each_line.map(&:chomp))

    corners, borders, content = resolve_tiles(tiles)

    top_left     = corners.select { |c| c.neighbour(:right) && c.neighbour(:bottom) }
    top_right    = corners.select { |c| c.neighbour(:left) && c.neighbour(:bottom) }

    bottom_right = corners.select { |c| c.neighbour(:left) && c.neighbour(:top) }
    bottom_left  = corners.select { |c| c.neighbour(:right) && c.neighbour(:top) }
    binding.irb
  end

  def self.parse_tiles(input)
    input.split(/^$/).map do |tile_input|
      Tile.new(tile_input)
    end
  end

  def self.resolve_tiles(tiles)
    lookup = {}

    tiles.each do |tile|
      tile.add_to(lookup)
    end

    tiles.each do |tile|
      tile.resolve_matches(lookup)
    end

    corner_tiles = []
    border_tiles = []
    content_tiles = []

    tiles.each do |tile|
      case tile.matches.count
      when 4
        corner_tiles << tile
      when 6
        border_tiles << tile
      else
        content_tiles << tile
      end
    end
    [corner_tiles, border_tiles, content_tiles]
  end
end
