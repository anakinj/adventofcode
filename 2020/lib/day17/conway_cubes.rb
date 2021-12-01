# frozen_string_literal: true

# rubocop:disable Naming/MethodParameterName
module ConwayCubes
  class FourDCube
    STATE_ACTIVE   = '#'
    STATE_INACTIVE = '.'

    attr_reader :cubicle, :x, :y, :z, :w

    def initialize(cubicle, w, z, y, x, state = STATE_INACTIVE) # rubocop:disable Metrics/ParameterLists
      @cubicle = cubicle
      @x = x
      @y = y
      @z = z
      @w = w
      @state = state
      @next_state = nil
    end

    def active?
      @state == STATE_ACTIVE
    end

    def neighbours
      @neighbours ||= begin
        n = []
        [x - 1, x, x + 1].each do |x|
          [y - 1, y, y + 1].each do |y|
            [z - 1, z, z + 1].each do |z|
              [w - 1, w, w + 1].each do |w|
                cube = cubicle.cube_at(w, z, y, x)
                n << cube if cube != self
              end
            end
          end
        end
        n
      end
    end

    def prepare_cycle
      active_neighbours = neighbours.count(&:active?)
      @next_state = @state

      if active?
        return if [2, 3].include?(active_neighbours)

        @next_state = STATE_INACTIVE
      elsif active_neighbours == 3
        @next_state = STATE_ACTIVE
      end
    end

    def cycle!
      @state = @next_state
      @next_state = nil
    end

    def to_s
      @state
    end
  end

  class FourDCubicle
    attr_reader :cubes, :dimensions

    def initialize
      @dimensions = {}
      @cubes      = []
    end

    def cube_at(w, z, y, x)
      cube = dimension_at(w, z, y)[x]

      return cube if cube

      add_cube_at(w, z, y, x)
    end

    def add_cube_at(w, z, y, x, state = Cube::STATE_INACTIVE)
      FourDCube.new(self, w, z, y, x, state).tap do |cube|
        cubes << cube
        dimension_at(w, z, y)[x] = cube
      end
    end

    def dimension_at(w, z, y)
      w_dim = (dimensions[w] ||= {})
      z_dim = (w_dim[z] ||= {})
      (z_dim[y] ||= {})
    end

    def cycle!
      cubes.dup.each(&:neighbours)

      current_cubes = cubes.dup
      current_cubes.each(&:prepare_cycle)
      current_cubes.each(&:cycle!)
    end

    def self.from_input(input)
      new.tap do |cubicle|
        input.each_line.with_index do |line, x|
          line.chomp.chars.each.with_index do |char, y|
            cubicle.add_cube_at(0, 0, y, x, char)
          end
        end
      end
    end
  end

  class Cube
    STATE_ACTIVE   = '#'
    STATE_INACTIVE = '.'

    attr_reader :cubicle, :x, :y, :z

    def initialize(cubicle, z, y, x, state = STATE_INACTIVE)
      @cubicle = cubicle
      @x = x
      @y = y
      @z = z
      @state = state
      @next_state = nil
    end

    def active?
      @state == STATE_ACTIVE
    end

    def neighbours
      @neighbours ||= begin
        n = []
        [x - 1, x, x + 1].each do |x|
          [y - 1, y, y + 1].each do |y|
            [z - 1, z, z + 1].each do |z|
              cube = cubicle.cube_at(z, y, x)
              n << cube if cube != self
            end
          end
        end
        n
      end
    end

    def prepare_cycle
      active_neighbours = neighbours.count(&:active?)
      @next_state = @state

      if active?
        return if [2, 3].include?(active_neighbours)

        @next_state = STATE_INACTIVE
      elsif active_neighbours == 3
        @next_state = STATE_ACTIVE
      end
    end

    def cycle!
      @state = @next_state
      @next_state = nil
    end

    def to_s
      @state
    end
  end

  class Cubicle
    attr_reader :cubes, :dimensions

    def initialize
      @dimensions = {}
      @cubes      = []
    end

    def cube_at(z, y, x)
      cube = dimension_at(z, y)[x]

      return cube if cube

      add_cube_at(z, y, x)
    end

    def add_cube_at(z, y, x, state = Cube::STATE_INACTIVE)
      Cube.new(self, z, y, x, state).tap do |cube|
        cubes << cube
        dimension_at(z, y)[x] = cube
      end
    end

    def dimension_at(z, y)
      z_dim = (dimensions[z] ||= {})
      (z_dim[y] ||= {})
    end

    def cycle!
      cubes.dup.each(&:neighbours)
      current_cubes = cubes.dup
      current_cubes.each(&:prepare_cycle)
      current_cubes.each(&:cycle!)
    end

    def self.from_input(input)
      new.tap do |cubicle|
        input.each_line.with_index do |line, x|
          line.chomp.chars.each.with_index do |char, y|
            cubicle.add_cube_at(0, y, x, char)
          end
        end
      end
    end
  end

  def self.four_d_cycle(input, cycle_count: 6)
    cubicle = FourDCubicle.from_input(input)
    cycle_count.times do |_cycle|
      yield(cubicle) if block_given?
      cubicle.cycle!
    end
    cubicle.cubes.count(&:active?)
  end

  def self.cycle(input, cycle_count: 6)
    cubicle = Cubicle.from_input(input)

    cycle_count.times do |_cycle|
      yield(cubicle) if block_given?
      cubicle.cycle!
    end
    cubicle.cubes.count(&:active?)
  end
end
# rubocop:enable Naming/MethodParameterName
