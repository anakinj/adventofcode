# frozen_string_literal: true

class TicketTranslation
  class Rule
    RULE_REGEX = /^(?<field>.*): (?<start1>\d+)-(?<end1>\d+) or (?<start2>\d+)-(?<end2>\d+)$/.freeze
    def initialize(rule_data)
      rule_match = rule_data.match(RULE_REGEX)
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
    [@raw_my_ticket, @raw_nearby_tickets].each(&:shift)
  end

  def rules
    @rules ||= @raw_rules.map { |r| Rule.new(r) }
  end

  def tickets
    @tickets ||= @raw_nearby_tickets.map { |t| t.split(',').map(&:to_i) }
  end

  def error_rate
    tickets.map do |ticket|
      ticket.reject { |v| one_valid_rule?(v) }
    end.flatten.sum
  end

  def one_valid_rule?(value)
    rules.any? { |r| r.valid?(value) }
  end
end
