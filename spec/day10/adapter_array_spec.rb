# frozen_string_literal: true

RSpec.describe AdapterArray do
  describe '.differences_multiplied' do
    subject { described_class.differences_multiplied(input) }
    context 'when example is given' do
      let(:input) { read_file('day10/example1') }
      it { is_expected.to eq(35) }
    end
    context 'when second example is given' do
      let(:input) { read_file('day10/example2') }
      it { is_expected.to eq(220) }
    end
    context 'when data is given' do
      let(:input) { read_file('day10/input') }
      it { is_expected.to eq(2376) }
    end
  end

  describe '.count_combos' do
    subject { described_class.count_combos(input) }
    context 'when example is given' do
      let(:input) { read_file('day10/example1') }
      it { is_expected.to eq(8) }
    end
    context 'when second example is given' do
      let(:input) { read_file('day10/example2') }
      it { is_expected.to eq(19_208) }
    end
    context 'when data is given' do
      let(:input) { read_file('day10/input') }
      it { is_expected.to eq(129_586_085_429_248) }
    end
  end
end
