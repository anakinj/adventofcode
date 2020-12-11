# frozen_string_literal: true

RSpec.describe SeatingSystem do
  describe '.occupied' do
    subject { described_class.occupied(input) }
    context 'when example is given' do
      let(:input) { read_file('day11/example1') }
      it { is_expected.to eq(37) }
    end
    context 'when input is given' do
      let(:input) { read_file('day11/input') }
      it { is_expected.to eq(2152) }
    end

    context 'when only interested in seats' do
      subject { described_class.occupied(input, ::SeatingSystem::Seat, 5) }

      context 'when example is given' do
        let(:input) { read_file('day11/example1') }
        it { is_expected.to eq(26) }
      end
      context 'when input is given' do
        let(:input) { read_file('day11/input') }
        it { is_expected.to eq(1937) }
      end
    end
  end
end
