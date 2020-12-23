# frozen_string_literal: true

RSpec.describe CrabCombat do
  describe 'regular game' do
    subject { described_class.new(input).play(:regular) }
    context 'when example is given' do
      let(:input) { read_file('day22/example') }
      it { is_expected.to eq(306) }
    end

    context 'when input is given' do
      let(:input) { read_file('day22/input') }
      it { is_expected.to eq(35_202) }
    end
  end

  describe 'recursive combat game' do
    subject { described_class.new(input).play(:recursive) }
    context 'when example is given' do
      let(:input) { read_file('day22/example') }
      it { is_expected.to eq(291) }
    end

    context 'when example2 is given' do
      let(:input) { read_file('day22/example2') }
      it { is_expected.to eq(105) }
    end

    context 'when input is given' do
      let(:input) { read_file('day22/input') }
      it { is_expected.to eq(32_317) }
    end
  end
end
