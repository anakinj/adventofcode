# frozen_string_literal: true

module OperationOrder
  def self.calculate(expressions)
    expressions.each_line.map(&:chomp).map do |expression|
      calculate_one(expression)
    end.sum
  end

  def self.calculate_one(expression)
    process_parenthesis(expression)
  end

  PARENTHESIS_MATCHER = /(?<p>\((?:(?> [^()]+ )|\g<p>)*\))/x.freeze

  def self.process_parenthesis(expression)
    while (match = PARENTHESIS_MATCHER.match(expression))
      sum = process_parenthesis(match[:p][1..-2])
      expression.gsub!(match[:p], sum.to_s)
    end
    process_simple(expression)
  end

  def self.process_simple(expression)
    parts = expression.split(' ')
    left = nil
    until parts.empty?
      left ||= parts.shift
      operator = parts.shift
      right    = parts.shift

      left = left.to_i.send(operator, right.to_i)
    end
    left
  end
end
