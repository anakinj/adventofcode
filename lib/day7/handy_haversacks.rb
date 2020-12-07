# frozen_string_literal: true

module HandyHaversacks
  BAG_REGEX     = /^(?<color>.*) bags* contain (?<content>.*)$/.freeze
  CONTENT_REGEX = /(?<count>\d)*\s?(?<color>\w*\s\w*) bags?/.freeze
  NO_OTHER      = 'no other'

  def self.count_parents(input, color)
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
end
