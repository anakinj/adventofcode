# frozen_string_literal: true

module BinaryBoarding
  def self.max_seat_id(input)
    seat_ids = process_boarding_passes(input).map { |seat| seat[2] }
    seat_ids.max
  end

  def self.find_missing_seat(input)
    seat_ids = process_boarding_passes(input).map { |seat| seat[2] }
    ((seat_ids.min..seat_ids.max).to_a - seat_ids).first
  end

  def self.process_boarding_passes(input)
    input.each_line.map(&:chomp).map do |pass|
      process_boarding_pass(pass)
    end
  end

  def self.process_boarding_pass(boarding_pass)
    row  = find_one((0..127).to_a, path: boarding_pass[0..6], left: 'F', right: 'B')
    seat = find_one((0..7).to_a, path: boarding_pass[7..9], left: 'L', right: 'R')
    id   = row * 8 + seat

    [row, seat, id]
  end

  def self.find_one(arr, path:, left:, right:)
    path.each_char do |char|
      middle = arr.size / 2
      arr = if char == left
              (arr.first..arr[middle - 1]).to_a
            elsif char == right
              (arr[middle]..arr.last).to_a
            end
    end

    arr.first
  end
end
