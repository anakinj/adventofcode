# frozen_string_literal: true

RSpec.describe PasswordPolicy do
  describe '.detect_valid_passwords' do
    context 'when the short list is given' do
      let(:input) { File.read(File.join(__dir__, 'input1')) }
      it 'detects 2 valid passwords' do
        valid_passwords = described_class.detect_valid_passwords(input)

        expect(valid_passwords).to eq(%w[abcde ccccccccc])
      end
    end

    context 'when the long list is given' do
      let(:input) { File.read(File.join(__dir__, 'input2')) }
      it 'detects the valid passwords' do
        valid_passwords = described_class.detect_valid_passwords(input)

        expect(valid_passwords.count).to eq(456)
      end
    end
  end

  describe '.detect_valid_tobbogan_passwords' do
    context 'when the short list is given' do
      let(:input) { File.read(File.join(__dir__, 'input1')) }
      it 'detects one valid password' do
        valid_passwords = described_class.detect_valid_tobbogan_passwords(input)
        expect(valid_passwords).to eq(['abcde'])
      end
    end
    context 'when the long list is given' do
      let(:input) { File.read(File.join(__dir__, 'input2')) }
      it 'detects the valid passwords' do
        valid_passwords = described_class.detect_valid_tobbogan_passwords(input)

        expect(valid_passwords.count).to eq(308)
      end
    end
  end
end
