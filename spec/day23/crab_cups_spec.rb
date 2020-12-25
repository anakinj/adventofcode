# frozen_string_literal: true

RSpec.describe CrabCups do
  describe 'part 1' do
    subject { described_class.new(input).part1! }
    context 'when example is given' do
      let(:input) { '389125467' }
      it { is_expected.to eq(67_384_529) }
    end

    context 'when input is given' do
      let(:input) { '326519478' }
      it { is_expected.to eq(25_368_479) }
    end
  end

  describe 'part 2' do
    subject { described_class.new(input).part2! }
    context 'when example is given' do
      let(:input) { '389125467' }
      it { is_expected.to eq(149_245_887_792) }
    end

    context 'when input is given' do
      let(:input) { '326519478' }
      it { is_expected.to eq(44_541_319_250) }
    end
  end
end
