# frozen_string_literal: true

RSpec.describe ComboBreaker do
  describe 'part 1' do
    subject { described_class.new(input).part1! }
    context 'when example is given' do
      let(:input) { read_file('day25/example') }
      it { is_expected.to eq(14_897_079) }
    end

    context 'when input is given' do
      let(:input) { read_file('day25/input') }
      it { is_expected.to eq(6_011_069) }
    end
  end
end
