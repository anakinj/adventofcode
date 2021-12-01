# frozen_string_literal: true

module AdapterArray
  def self.adapters_from_input(input)
    adapters = input.each_line.map(&:to_i).sort
    [0] + adapters + [adapters.max + 3]
  end

  def self.differences_multiplied(input)
    adapters = adapters_from_input(input)
    differences = (0..adapters.size - 2).each_with_object([]) do |adapter_index, diffs|
      diffs << adapters[adapter_index + 1] - adapters[adapter_index]
    end

    differences.count(1) * differences.count(3)
  end

  def self.count_combos(input)
    ComboCounter.new(adapters_from_input(input)).combination_count
  end

  class ComboCounter
    attr_reader :adapters, :paths_taken

    def initialize(adapters)
      @adapters = adapters
      @paths_taken = {}
    end

    def combination_count
      count_combos(adapters.min, adapters.max)
    end

    def count_combos(current_adapter, end_adapter)
      return paths_taken[current_adapter] if paths_taken.include?(current_adapter)
      return 1 if current_adapter == end_adapter

      paths_taken[current_adapter] = (1..3).map { |step| current_adapter + step }
                                           .select { |possible_adapter| adapters.include?(possible_adapter) }
                                           .map { |validated_adapter| count_combos(validated_adapter, end_adapter) }
                                           .sum
    end
  end
end
