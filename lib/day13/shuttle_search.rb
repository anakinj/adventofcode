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

  def self.coin_contest_answer(input) # rubocop:disable Metrics/MethodLength
    busses       = parse_and_sort_busses(input)
    first_bus    = busses.first
    time_step    = first_bus[:number]
    current_time = first_bus[:number] - first_bus[:pos]

    busses.each do |bus|
      current_time += time_step until valid_time?(current_time, bus)

      subset_time = current_time + time_step
      subset      = busses[0..(busses.index(bus))]

      subset_time += time_step until subset.all? { |sub_bus| valid_time?(subset_time, sub_bus) }

      time_step = subset_time - current_time
    end

    current_time
  end

  def self.parse_and_sort_busses(input)
    busses = input.each_line.to_a.last.split(',')
                  .map.with_index.each_with_object([]) do |(bus, pos), obj|
      next if bus == 'x'

      obj << { number: bus.to_i, pos: pos }
    end

    busses.sort_by { |v| -v[:number] }
  end

  def self.valid_time?(time, bus)
    ((time + bus[:pos]) % bus[:number]).zero?
  end
end
