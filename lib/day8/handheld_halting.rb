# frozen_string_literal: true

module HandheldHalting
  class Bootloader
    SWAPPABLE = %w[jmp nop].freeze
    def initialize(instructions)
      @instructions = instructions.each_line.map { |l| l.split(' ') }
      @acc = 0
      @pos = 0
      @stack = []
    end

    def fix_and_execute
      fix_pos = 0
      original_instructions = @instructions.dup
      begin
        execute!
      rescue StandardError
        @instructions = original_instructions.dup
        while ((inst, val) = @instructions[fix_pos += 1])
          case inst
          when 'jmp'
            @instructions[fix_pos] = ['nop', val]
          when 'nop'
            @instructions[fix_pos] = ['jmp', val]
          else
            next
          end

          break
        end
        retry
      end
      @acc
    end

    def execute!
      @acc = 0
      @pos = 0
      @stack = []
      while ((inst, val) = @instructions[@pos])
        # p "#{@pos}: #{inst} #{val} #{@acc} #{@stack.size}"

        raise 'Infinite loop detected' if @stack.include?(@pos)

        @stack << @pos
        @pos += send(inst, val)
      end

      @acc
    end

    def execute
      execute!
    rescue StandardError
      @acc
    end

    private

    def nop(_val)
      1
    end

    def acc(val)
      @acc += val.to_i
      1
    end

    def jmp(val)
      val.to_i
    end
  end
end
