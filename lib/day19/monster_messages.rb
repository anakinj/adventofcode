# frozen_string_literal: true

module MonsterMessages
  RULE_REGEX = /(?<id>\d+): (?<rule>.*)/.freeze

  def self.valid_message_count(input)
    rules, messages = input.split(/^$/)
    parsed_rules = parse_rules(rules)

    rule_regex = Regexp.new("^#{build_rule(parsed_rules, '0')}$")
    messages.each_line.count { |m| rule_regex.match(m) }
  end

  def self.valid_message_count_with_replacement(input)
    rules, messages = input.split(/^$/)
    parsed_rules = parse_rules(rules)
    replace_rules(parsed_rules)
    rule_regex = Regexp.new("^#{build_rule(parsed_rules, '0')}$")
    messages.each_line.count { |m| rule_regex.match(m) }
  end

  def self.replace_rules(rules)
    rules['8'] = '42 | 42 8'
    rules['11'] = '42 31 | 42 11 31'
  end

  def self.parse_rules(rules)
    rules.each_line.each_with_object({}) do |r, h|
      m = RULE_REGEX.match(r)
      h[m[:id]] = m[:rule].gsub('"', '')
    end
  end

  def self.build_rule(rules, start, depth = 0)
    return '' if depth > 15

    rule = rules[start]
    combined = []
    rule.split(' ').each do |part|
      combined << if part =~ /\d+/
                    "(#{build_rule(rules, part, depth + 1)})"
                  else
                    part
                  end
    end
    combined.join
  end
end
