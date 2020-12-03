# frozen_string_literal: true

RSpec.describe TobogganTrajectory do
  describe '.count_threes' do
    context 'when short track is used' do
      let(:input) { File.read(File.join(__dir__, 'input1')) }
      it 'detects 2 valid passwords' do
        expect(described_class.count_trees(input)).to eq(7)
      end
    end

    context 'when the long list is given' do
      let(:input) { File.read(File.join(__dir__, 'input2')) }
      it 'detects the valid passwords' do
        expect(described_class.count_trees(input)).to eq(223)
      end
    end
  end
end
