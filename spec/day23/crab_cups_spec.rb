# frozen_string_literal: true

RSpec.describe CrabCups do
  describe 'part 1' do
    subject { described_class.new(input).play! }
    context 'when example is given' do
      let(:input) { '389125467' }
      it { is_expected.to eq(67_384_529) }
    end

    context 'when input is given' do
      let(:input) { '326519478' }
      it { is_expected.to eq(25_368_479) }
    end
  end
end
