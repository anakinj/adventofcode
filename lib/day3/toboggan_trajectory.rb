# frozen_string_literal: true

module TobogganTrajectory
  def self.count_trees(input)
    track = input.each_line.map(&:chomp)

    index = 0
    track.count do |row|
      index -= row.size if index >= row.size
      (row[index] == '#').tap do
        index += 3
      end
    end
  end
end
