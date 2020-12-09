# frozen_string_literal: true

RSpec.describe XmasEncodingError do
  describe '.first_invalid' do
    context 'when example is given' do
      let(:input) { read_file('day9/example') }
      it 'counts to 127' do
        expect(described_class.first_invalid(input, premable_length: 5)).to eq(127)
      end
    end
    context 'when data is given' do
      let(:input) { read_file('day9/input') }
      it 'counts to 248131121' do
        expect(described_class.first_invalid(input)).to eq(248_131_121)
      end
    end
  end

  describe '.find_weakness' do
    context 'when example is given ' do
      let(:input) { read_file('day9/example') }
      it 'returns 62' do
        expect(described_class.find_weakness(input, premable_length: 5)).to eq(62)
      end
    end

    context 'when data is given' do
      let(:input) { read_file('day9/input') }
      it 'returns 31580383' do
        expect(described_class.find_weakness(input)).to eq(31_580_383)
      end
    end
  end
end
