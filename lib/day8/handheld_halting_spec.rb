# frozen_string_literal: true

module HandheldHalting
  class Bootloader
    def initialize(instructions)
      @instructions = instructions.each_line.map { |l| l.split(' ') }
      @acc = 0
      @pos = 0
      @stack = []
    end

    def execute
      while ((inst, val) = @instructions[@pos])
        @stack << @pos
        send(inst, val)
        break if @stack.include?(@pos)
      end

      @acc
    end

    private

    def nop(_val)
      @pos += 1
    end

    def acc(val)
      @acc += val.to_i
      @pos += 1
    end

    def jmp(val)
      @pos += val.to_i
    end
  end
end
