# frozen_string_literal: true

RSpec.describe RainRisk do
  describe '.' do
    subject { described_class.manhattan_position(input) }
    context 'when example is given' do
      let(:input) { read_file('day12/example1') }
      it { is_expected.to eq(25) }
    end
    context 'when input is given' do
      let(:input) { read_file('day12/input') }
      it { is_expected.to eq(1441) }
    end
  end
end
