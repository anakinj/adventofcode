# frozen_string_literal: true

RSpec.describe AdapterArray do
  describe '.differences_multiplied' do
    context 'when example is given' do
      let(:input) { read_file('day10/example1') }
      it 'returns 35' do
        expect(described_class.differences_multiplied(input)).to eq(35)
      end
    end
    context 'when second example is given' do
      let(:input) { read_file('day10/example2') }
      it 'returns 220' do
        expect(described_class.differences_multiplied(input)).to eq(220)
      end
    end
    context 'when data is given' do
      let(:input) { read_file('day10/input') }
      it 'returns 2376' do
        expect(described_class.differences_multiplied(input)).to eq(2376)
      end
    end
  end
end
