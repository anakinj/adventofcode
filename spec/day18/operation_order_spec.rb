# frozen_string_literal: true

RSpec.describe OperationOrder do
  describe '.calculate' do
    subject { described_class.calculate(input) }

    context 'when 2 * 3 + (4 * 5) is given' do
      let(:input) { '2 * 3 + (4 * 5)' }
      it { is_expected.to eq(26) }
    end

    context 'when 5 + (8 * 3 + 9 + 3 * 4 * 3) is given' do
      let(:input) { '5 + (8 * 3 + 9 + 3 * 4 * 3)' }
      it { is_expected.to eq(437) }
    end

    context 'when 5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4)) is given' do
      let(:input) { '5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))' }
      it { is_expected.to eq(12_240) }
    end

    context 'when ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2 is given' do
      let(:input) { '((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2' }
      it { is_expected.to eq(13_632) }
    end

    context 'when input is given' do
      let(:input) { read_file('day18/input') }
      it { is_expected.to eq(375) }
    end
  end
end
