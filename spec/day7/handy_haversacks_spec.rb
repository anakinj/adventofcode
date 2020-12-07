# frozen_string_literal: true

RSpec.describe HandyHaversacks do
  let(:example) { File.read(File.join(__dir__, 'example')) }
  let(:example2) { File.read(File.join(__dir__, 'example2')) }
  let(:input) { File.read(File.join(__dir__, 'input1')) }

  describe '.count_parents' do
    context 'when example is given' do
      it 'counts to 11' do
        expect(described_class.count_parents(example, 'shiny gold')).to eq(4)
      end
    end

    context 'when real input is given' do
      it 'counts to 131' do
        expect(described_class.count_parents(input, 'shiny gold')).to eq(131)
      end
    end
  end

  describe '.count_totals' do
    context 'when example is given' do
      it 'counts to 36' do
        expect(described_class.count_totals(example, 'shiny gold')).to eq(32)
      end
    end

    context 'when example2 is given' do
      it 'counts to 126' do
        expect(described_class.count_totals(example2, 'shiny gold')).to eq(126)
      end
    end

    context 'when real input is given' do
      it 'counts to 11261' do
        expect(described_class.count_totals(input, 'shiny gold')).to eq(11261)
      end
    end
  end
end
