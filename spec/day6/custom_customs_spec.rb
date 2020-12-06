# frozen_string_literal: true

RSpec.describe CustomCustoms do
  let(:example) { File.read(File.join(__dir__, 'example')) }
  let(:input) { File.read(File.join(__dir__, 'input1')) }

  context 'when example is given' do
    it 'counts to 11' do
      expect(described_class.count_answers(example)).to eq(11)
    end
  end

  context 'when example is given' do
    it 'counts to 6437' do
      expect(described_class.count_answers(input)).to eq(6437)
    end
  end
end
