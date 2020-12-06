# frozen_string_literal: true

module CustomCustoms
  def self.count_answers(input)
    input.split(/^$/).map do |group|
      group.split("\n").reject(&:empty?).inject(&:+).chars.uniq.size
    end.inject(&:+)
  end
end
