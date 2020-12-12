# frozen_string_literal: true

RSpec.describe RainRisk do
  describe '.manhattan_position' do
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

  describe '.manhattan_position_part2' do
    subject { described_class.manhattan_position_with_waypoint(input) }
    context 'when example is given' do
      let(:input) { read_file('day12/example1') }
      it { is_expected.to eq(286) }
    end
    context 'when input is given' do
      let(:input) { read_file('day12/input') }
      it { is_expected.to eq(1441) }
    end
  end
end
