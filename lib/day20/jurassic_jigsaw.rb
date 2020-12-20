# frozen_string_literal: true

module JurassicJigsaw
  class Tile
    attr_reader :id, :top, :left, :right, :bottom, :matches

    ID_REGEX = /Tile (?<id>\d+):/.freeze
    def initialize(tile_input)
      @lines = []
      @left = []
      @right = []
      tile_input.each_line.map(&:chomp).each do |line|
        next if line.empty?

        if (match = ID_REGEX.match(line))
          @id = match[:id].to_i
        else
          @top ||= line
          @left << line.chars[0]
          @right << line.chars[-1]
          @lines << line
          @bottom = line
        end
      end
      @left = @left.join
      @right = @right.join
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
    tiles = input.split(/^$/).map do |tile_input|
      Tile.new(tile_input)
    end

    lookup = {}

    tiles.each do |tile|
      tile.add_to(lookup)
    end

    tiles.each do |tile|
      tile.resolve_matches(lookup)
    end

    tiles.select do |border_tile|
      border_tile.matches.count == 4
    end.map(&:id).inject(&:*)
  end
end
