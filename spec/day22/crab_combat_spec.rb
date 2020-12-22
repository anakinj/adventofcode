# frozen_string_literal: true

RSpec.describe CrabCombat do
  describe '.winner_total' do
    subject { described_class.new(input).winner_total }
    context 'when example is given' do
      let(:input) { read_file('day22/example') }
      it { is_expected.to eq(306) }
    end

    context 'when input is given' do
      let(:input) { read_file('day22/input') }
      it { is_expected.to eq(35_202) }
    end
  end
end
