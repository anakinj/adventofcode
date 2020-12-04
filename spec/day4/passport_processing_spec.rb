# frozen_string_literal: true

RSpec.describe PassportProcessing do
  context 'when example data is used' do
    let(:input) { File.read(File.join(__dir__, 'input1')) }
    it 'counts to 2' do
      expect(described_class.count_valid(input)).to eq(2)
    end
  end

  context 'when real data is used' do
    let(:input) { File.read(File.join(__dir__, 'input2')) }
    it 'counts to 170' do
      expect(described_class.count_valid(input)).to eq(170)
    end
  end
end
