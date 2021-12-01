# frozen_string_literal: true

module TobogganTrajectory
  def self.count_trees(input, down: 1, right: 3)
    track = input.each_line.map(&:chomp)

    index = 0
    tree_count = 0
    track.each_with_index do |row, distance|
      next if distance % down != 0

      index -= row.size if index >= row.size
      tree_count += 1 if row[index] == '#'
      index += right
    end
    tree_count
  end

  def self.count_all_slopes(input)
    [count_trees(input, right: 1, down: 1),
     count_trees(input, right: 3, down: 1),
     count_trees(input, right: 5, down: 1),
     count_trees(input, right: 7, down: 1),
     count_trees(input, right: 1, down: 2)].inject(:*)
  end
end
