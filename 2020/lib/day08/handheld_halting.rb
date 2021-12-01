# frozen_string_literal: true

module HandheldHalting
  class Interpreter
    def initialize(instructions)
      @instructions = instructions
      @acc = 0
      @pos = 0
      @stack = []
    end

    def execute!
      while ((inst, val) = @instructions[@pos])
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

    def nop(*)
      1
    end

    def acc(val)
      @acc += val
      1
    end

    def jmp(val)
      val
    end
  end

  class Fixer
    SWAPPABLE = {
      'jmp' => 'nop',
      'nop' => 'jmp'
    }.freeze

    def initialize(instructions)
      @instructions = instructions
      @fix_pos = 0
    end

    def while_fixing
      yield(fix_instruction(@instructions.dup))
    rescue StandardError
      retry
    end

    def fix_instruction(instructions)
      while ((inst, val) = instructions[@fix_pos += 1])
        next unless (new_instruction = SWAPPABLE[inst])

        instructions[@fix_pos] = [new_instruction, val]
        break
      end
      instructions
    end
  end

  def self.fix_and_execute(instructions)
    Fixer.new(parse_instructions(instructions)).while_fixing do |fixed_instructions|
      Interpreter.new(fixed_instructions).execute!
    end
  end

  def self.execute(instructions)
    Interpreter.new(parse_instructions(instructions)).execute
  end

  def self.parse_instructions(instructions)
    instructions.each_line.map do |l|
      inst, val = l.split(' ')
      [inst, val.to_i]
    end
  end
end
