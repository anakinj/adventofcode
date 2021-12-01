# frozen_string_literal: true

RSpec.describe TobogganTrajectory do
  context 'when short track is used' do
    let(:input) { File.read(File.join(__dir__, 'input1')) }
    it 'counts 7 trees' do
      expect(described_class.count_trees(input)).to eq(7)
    end

    it 'calculates 336' do
      expect(described_class.count_all_slopes(input)).to eq(336)
    end
  end

  context 'when the long list is given' do
    let(:input) { File.read(File.join(__dir__, 'input2')) }
    it 'counts all the threes' do
      expect(described_class.count_trees(input)).to eq(223)
    end
    it 'comes up with a number' do
      expect(described_class.count_all_slopes(input)).to eq(3_517_401_300)
    end
  end
end
