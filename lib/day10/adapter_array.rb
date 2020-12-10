# frozen_string_literal: true

module AdapterArray
  def self.differences_multiplied(input)
    adapters = input.each_line.map(&:to_i).sort

    adapters = [0] + adapters + [adapters.max + 3]

    differences = (0..adapters.size - 2).each_with_object([]) do |adapter_index, diffs|
      diffs << adapters[adapter_index + 1] - adapters[adapter_index]
    end

    differences.count(1) * differences.count(3)
  end
end
