# frozen_string_literal: true

module HandyHaversacks
  BAG_REGEX     = /^(?<color>.*) bags* contain (?<content>.*)$/.freeze
  CONTENT_REGEX = /(?<count>\d)*\s?(?<color>\w*\s\w*) bags?/.freeze
  NO_OTHER      = 'no other'

  def self.count_parents(input, color)
    bags = parse_bags(input)

    parents = Set.new
    iterate_parents(bags[color]) do |parent|
      parents << parent[:color]
    end
    parents.size
  end

  def self.count_totals(input, color)
    bags = parse_bags(input)
    count_children(bags, bags[color][:children])
  end

  def self.count_children(all_bags, children)
    children.map do |color, count|
      count_children(all_bags, all_bags[color][:children]) * count + count
    end.sum
  end

  def self.parse_bags(input)
    bags = {}
    input.each_line do |line|
      match = BAG_REGEX.match(line)
      match[:content].split(',')
                     .map(&:strip)
                     .map { |part| CONTENT_REGEX.match(part) }
                     .each do |bag|
                       container = bags[match[:color]] ||= {
                         color: match[:color],
                         parents: [],
                         children: {}
                       }
                       content = bags[bag[:color]] ||= {
                         color: bag[:color],
                         parents: [],
                         children: {}
                       }
                       content[:parents] << container
                       container[:children][bag[:color]] = (bag[:count] || 1).to_i unless bag[:color] == NO_OTHER
                     end
    end
    bags
  end

  def self.iterate_parents(bag, &block)
    return if bag.nil?

    bag[:parents].each do |parent|
      yield(parent)
      iterate_parents(parent, &block)
    end
  end
end
