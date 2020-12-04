# frozen_string_literal: true

module PassportProcessing
  def self.count_valid(input)
    passports = input.split(/^$/).map do |passport_section|
      passport_section.split(/\s/)
                      .reject(&:empty?)
                      .map { |kv| kv.split(':') }
                      .each_with_object({}) { |(key, value), hash| hash[key] = value }
    end

    passports.count { |passport| valid_passport?(passport) }
  end

  REQUIRED_FIELDS = %w[ecl pid eyr hcl byr iyr hgt].freeze

  def self.valid_passport?(passport)
    (REQUIRED_FIELDS - passport.keys).empty?
  end
end
