# frozen_string_literal: true

module PasswordPolicy
  PATTERN = /(\d+)-(\d+) (.): (\w*)/.freeze
  def self.detect_valid_passwords(input)
    passwords = parse_password_list(input)
    passwords.select { |password| valid_password?(password) }
             .map { |password| password[:password] }
  end

  def self.detect_valid_tobbogan_passwords(input)
    passwords = parse_password_list(input)
    passwords.select { |password| valid_toboggan_password?(password) }
             .map { |password| password[:password] }
  end

  def self.parse_password_list(input)
    input.each_line.map do |line|
      matches = PATTERN.match(line)
      {
        min: matches[1].to_i,
        max: matches[2].to_i,
        char: matches[3],
        password: matches[4]
      }
    end
  end

  def self.valid_password?(min:, max:, char:, password:)
    char_count = password.count(char)

    char_count >= min && char_count <= max
  end

  def self.valid_toboggan_password?(min:, max:, char:, password:)
    [password[min - 1], password[max - 1]].count(char) == 1
  end
end
