# frozen_string_literal: true

module AllergenAssessment
  class Food
    MATCHER = /(?<ingredients>.*)\(contains (?<allergens>.*)\)/.freeze
    attr_reader :ingredients, :allergens

    def initialize(input)
      matches = MATCHER.match(input)
      @ingredients = matches[:ingredients].split(' ').map(&:chomp)
      @allergens = matches[:allergens].split(', ').map(&:chomp)
    end
  end

  class FoodCollection
    attr_reader :foods

    def initialize(foods)
      @foods = foods
    end

    def ingredients
      foods.map(&:ingredients).flatten
    end

    def allergens
      foods.each_with_object({}) do |food, hash|
        food.allergens.each do |allergen|
          hash[allergen] = if hash.key?(allergen)
                             hash[allergen].intersection(food.ingredients)
                           else
                             food.ingredients.dup
                           end
        end
      end
    end

    def ingredients_with_allergens
      allergens.values.flatten.uniq
    end
  end

  def self.create_food_collection(input)
    FoodCollection.new(input.each_line.map(&:chomp).map do |line|
      Food.new(line)
    end)
  end

  def self.dangerous_ingredients(input)
    collection = create_food_collection(input)

    allergens  = collection.allergens

    while allergens.values.any? { |v| v.size > 1 }
      allergens.each do |a1, i1|
        next if i1.size > 1

        allergens.each do |a2, i2|
          next if a2 == a1

          i2.delete(i1.first)
        end
      end
    end

    collection.ingredients_with_allergens.sort_by do |a1|
      allergens.key([a1])
    end.join(',')
  end

  def self.count_ingredients(input)
    collection = create_food_collection(input)

    all_ingredients = collection.ingredients
    collection.ingredients_with_allergens.each do |allergen|
      all_ingredients.delete(allergen)
    end

    all_ingredients.size
  end
end
