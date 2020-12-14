# frozen_string_literal: true

module DockingData
  PARSER = /(?<key>.+)\s=\s(?<value>\w+)/.freeze
  MEM_PARSER = /mem\[(?<addr>\d+)\]/.freeze

  class Program
    attr_reader :mem

    def initialize
      @mem = {}
    end

    def tick(instruction)
      match = PARSER.match(instruction)
      case match[:key]
      when 'mask'
        @mask = match[:value]
      else
        write_to_mem(MEM_PARSER.match(match[:key])[:addr].to_i, match[:value].to_i)
      end
    end

    def tick2(instruction)
      match = PARSER.match(instruction)
      case match[:key]
      when 'mask'
        @mask = match[:value]
      else
        write_to_mem2(MEM_PARSER.match(match[:key])[:addr].to_i, match[:value].to_i)
      end
    end

    def write_to_mem2(pos, value)
      addresses = resolve_mem_addresses(pos)
      p addresses
      addresses.each do |addr|
        mem[addr] = value
      end
    end

    def write_to_mem(pos, value)
      mem[pos] = mask_value_v1(value)
    end

    def mask_value_v1(value)
      @mask.chars.reverse.zip(value.to_s(2).chars.reverse).map do |m, v|
        if m == 'X'
          v || '0'
        else
          m
        end
      end.reverse.join.to_i(2)
    end

    def resolve_mem_addresses(addr)
      a = @mask.chars.reverse.zip(addr.to_s(2).chars.reverse).map do |m, v|
        case m
        when '0'
          v ? [v] : ['0']
        when 'X'
          %w[0 1]
        else
          [m]
        end
      end
      a.reduce { |acc, n| acc.product(n).map(&:flatten) }.map(&:reverse).map(&:join).map { |v| v.to_i(2) }
    end

    def mem_sum
      mem.values.sum
    end
  end

  def self.execute(input)
    p = Program.new
    input.each_line do |line|
      p.tick(line)
    end
    p.mem_sum
  end

  def self.execute_v2(input)
    p = Program.new
    input.each_line do |line|
      p.tick2(line)
    end
    p.mem_sum
  end
end
