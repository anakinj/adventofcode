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

  def self.iterate_parents(bag, &block)
    return if bag.nil?

    bag[:parents].each do |parent|
      yield(parent)
      iterate_parents(parent, &block)
    end
  end

  def self.count_totals(input, color)
    bags = parse_bags(input)
    count_children(bags[color][:children])
  end

  def self.count_children(children)
    children.map do |color, count|
      count_children(color[:children]) * count + count
    end.sum
  end

  def self.parse_bags(input)
    parse_raw_bag_data(input).each_with_object({}) do |raw_bag, bags|
      parse_bag_content(raw_bag[:content]).each do |bag|
        container = bags[raw_bag[:color]] ||= create_bag(raw_bag[:color])
        content = bags[bag[:color]] ||= create_bag(bag[:color])
        content[:parents] << container
        next if bag[:color] == NO_OTHER

        container[:children][content] = (bag[:count] || 1).to_i
      end
    end
  end

  def self.parse_raw_bag_data(input)
    input.each_line.map { |line| BAG_REGEX.match(line) }
  end

  def self.parse_bag_content(content)
    content.split(',')
           .map(&:strip)
           .map { |part| CONTENT_REGEX.match(part) }
  end

  def self.create_bag(color)
    {
      color: color,
      parents: [],
      children: {}
    }
  end
end
