# frozen_string_literal: true

module PassportProcessing
  REQUIRED_FIELDS = %w[ecl pid eyr hcl byr iyr hgt].freeze

  ECL_VALUES = %w[amb blu brn gry grn hzl oth].freeze

  HGT_VALUES = {
    'cm' => 150..193,
    'in' => 59..76
  }.freeze

  VALIDATORS = {
    'byr' => ->(v) { (1920..2002).include?(v.to_i) },
    'iyr' => ->(v) { (2010..2020).include?(v.to_i) },
    'eyr' => ->(v) { (2020..2030).include?(v.to_i) },
    'hgt' => lambda { |v|
      (m = /^(?<height>\d+)(?<unit>cm|in)$/.match(v)) &&
        HGT_VALUES[m[:unit]].include?(m[:height].to_i)
    },
    'hcl' => ->(v) { /^\#{1}[0-9a-f]{6}$/ =~ v },
    'ecl' => ->(v) { ECL_VALUES.include?(v) },
    'pid' => ->(v) { /^\d{9}$/ =~ v },
    'cid' => ->(_v) { true }
  }.freeze

  def self.parse_passports(input)
    input.split(/^$/).map do |passport_section|
      passport_section.split(/\s/)
                      .reject(&:empty?)
                      .map { |kv| kv.split(':') }
                      .each_with_object({}) { |(key, value), hash| hash[key] = value }
    end
  end

  def self.count_passports_with_required_fields(input)
    parse_passports(input).count { |passport| required_fields?(passport.keys) }
  end

  def self.required_fields?(fields)
    (REQUIRED_FIELDS - fields).empty?
  end

  def self.count_valid_passports(input)
    parse_passports(input).count do |passport|
      required_fields?(passport.keys) &&
        passport.all? { |field, value| VALIDATORS[field].call(value) }
    end
  end
end
