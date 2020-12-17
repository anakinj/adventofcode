# frozen_string_literal: true

RSpec.describe ConwayCubes do
  describe '.cycle' do
    subject { described_class.cycle(input) }
    context 'when example is given' do
      let(:input) { read_file('day17/example') }
      it { is_expected.to eq(112) }
    end

    context 'when input is given' do
      let(:input) { read_file('day17/input') }
      it { is_expected.to eq(375) }
    end
  end

  describe '.cycle_with_4th_dimension' do
    subject { described_class.four_d_cycle(input) }
    context 'when example is given' do
      let(:input) { read_file('day17/example') }
      it { is_expected.to eq(848) }
    end

    context 'when input is given' do
      let(:input) { read_file('day17/input') }
      it { is_expected.to eq(2192) }
    end
  end
end
