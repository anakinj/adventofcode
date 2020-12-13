# frozen_string_literal: true

module ShuttleSearch
  def self.earliest(input)
    lines = input.each_line.to_a
    now = lines.first.to_i
    schedules = lines.last.split(',')
                     .reject { |s| s == 'x' }
                     .map(&:to_i)
                     .each_with_object({}) do |s, hsh|
      hsh[s] = (s * (now / s).floor) + s
    end
    earliest_departure_time = schedules.values.min
    schedules.key(earliest_departure_time) * (earliest_departure_time - now)
  end
end
