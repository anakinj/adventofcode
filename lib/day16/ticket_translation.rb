# frozen_string_literal: true

class TicketTranslation
  class Rule
    RULE_REGEX = /^(?<field>.*): (?<start1>\d+)-(?<end1>\d+) or (?<start2>\d+)-(?<end2>\d+)$/.freeze
    attr_reader :field

    def initialize(rule_data)
      rule_match = rule_data.match(RULE_REGEX)
      @field  = rule_match[:field]
      @ranges = [rule_match[:start1].to_i..rule_match[:end1].to_i,
                 rule_match[:start2].to_i..rule_match[:end2].to_i]
    end

    def valid?(value)
      @ranges.any? { |r| r.include?(value) }
    end
  end

  def initialize(input)
    @raw_rules, @raw_my_ticket, @raw_nearby_tickets = input.split(/^$/).map do |groups|
      groups.split("\n")
            .reject(&:empty?)
    end
    [@raw_my_ticket,
     @raw_nearby_tickets].each(&:shift)
  end

  def error_rate
    tickets.map do |ticket|
      ticket.reject { |v| one_valid_rule?(v) }
    end.flatten.sum
  end

  def fields_multiplied(field_matcher = /^departure/)
    indexes = figure_out_positions.each_with_object([]) do |(k, v), carry|
      next unless field_matcher.match(k)

      carry << v.first
    end

    indexes.map do |i|
      my_ticket[i]
    end.inject(&:*)
  end

  private

  def figure_out_positions
    matches = rule_matches

    until matches.values.all? { |v| v.size == 1 }
      singles = matches.values.select { |v| v.size == 1 }.map(&:first)

      matches.each_value do |v|
        next if v.size == 1

        singles.each { |s| v.delete(s) }
      end
    end
    matches
  end

  def rule_matches
    rules.each_with_object({}) do |rule, coll|
      matches = (0..my_ticket.size).select do |field_index|
        values = (valid_tickets + [my_ticket]).map { |t| t[field_index] }
        true if values.all? { |value| rule.valid?(value) }
      end
      coll[rule.field] = matches
    end
  end

  def valid_tickets
    @valid_tickets ||= tickets.select do |ticket|
      ticket.all? { |v| one_valid_rule?(v) }
    end
  end

  def rules
    @rules ||= @raw_rules.map { |r| Rule.new(r) }
  end

  def my_ticket
    @my_ticket ||= @raw_my_ticket.first.split(',').map(&:to_i)
  end

  def tickets
    @tickets ||= @raw_nearby_tickets.map { |t| t.split(',').map(&:to_i) }
  end

  def one_valid_rule?(value)
    rules.any? { |r| r.valid?(value) }
  end
end
