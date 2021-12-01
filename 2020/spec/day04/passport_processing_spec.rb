# frozen_string_literal: true

RSpec.describe PassportProcessing do
  describe 'part 1' do
    context 'when example data is used' do
      let(:input) { File.read(File.join(__dir__, 'input1')) }
      it 'counts to 2' do
        expect(described_class.count_passports_with_required_fields(input)).to eq(2)
      end
    end

    context 'when real data is used' do
      let(:input) { File.read(File.join(__dir__, 'input2')) }
      it 'counts to 170' do
        expect(described_class.count_passports_with_required_fields(input)).to eq(170)
      end
    end
  end

  describe 'part 2' do
    context 'when invalid passports given' do
      let(:input) { File.read(File.join(__dir__, 'invalid_passports')) }
      it 'counts to 2' do
        expect(described_class.count_valid_passports(input)).to eq(0)
      end
    end

    context 'when valid passports given' do
      let(:input) { File.read(File.join(__dir__, 'valid_passports')) }
      it 'counts to 170' do
        expect(described_class.count_valid_passports(input)).to eq(4)
      end
    end

    context 'when problem data given' do
      let(:input) { File.read(File.join(__dir__, 'input2')) }
      it 'counts to 170' do
        expect(described_class.count_valid_passports(input)).to eq(103)
      end
    end
  end
end
