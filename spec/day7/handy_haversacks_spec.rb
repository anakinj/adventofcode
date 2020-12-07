# frozen_string_literal: true

RSpec.describe HandyHaversacks do
  let(:example) { File.read(File.join(__dir__, 'example')) }
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
end
