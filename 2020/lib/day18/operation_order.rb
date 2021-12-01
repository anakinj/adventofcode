# frozen_string_literal: true

class OperationOrder
  def initialize(method = :simple)
    @method = method
  end

  def calculate(expressions)
    expressions.each_line.map(&:chomp).map do |expression|
      calculate_one(expression)
    end.sum
  end

  def calculate_one(expression)
    process_parenthesis(expression)
  end

  PARENTHESIS_MATCHER = /(?<p>\((?:(?> [^()]+ )|\g<p>)*\))/x.freeze

  def process_parenthesis(expression)
    while (match = PARENTHESIS_MATCHER.match(expression))
      sum = process_parenthesis(match[:p][1..-2])
      expression.gsub!(match[:p], sum.to_s)
    end
    send(@method, expression)
  end

  def advanced(expression)
    parts = expression.split(' ')

    while (i = parts.index('+'))
      parts[i] = parts[i - 1].to_i + parts[i + 1].to_i
      parts.delete_at(i + 1)
      parts.delete_at(i - 1)
    end

    return parts.first if parts.size == 1

    add(parts)
  end

  def simple(expression)
    add(expression.split(' '))
  end

  def add(parts)
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
