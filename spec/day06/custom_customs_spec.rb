# frozen_string_literal: true

RSpec.describe CustomCustoms do
  let(:example) { File.read(File.join(__dir__, 'example')) }
  let(:input) { File.read(File.join(__dir__, 'input1')) }

  describe '.count_answers' do
    context 'when example is given' do
      it 'counts to 11' do
        expect(described_class.count_answers(example)).to eq(11)
      end
    end

    context 'when real input is given' do
      it 'counts to 6437 unique answers' do
        expect(described_class.count_answers(input)).to eq(6437)
      end
    end
  end

  describe '.count_same_answers' do
    context 'when example is given' do
      it 'counts to 11' do
        expect(described_class.count_same_answers(example)).to eq(6)
      end
    end
    context 'when real input is given' do
      it 'counts to 6437 unique answers' do
        expect(described_class.count_same_answers(input)).to eq(3229)
      end
    end
  end
end
